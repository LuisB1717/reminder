import 'package:reminder/core/entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Entity>> getEntities({
  String? districtId,
  List<int>? townIds,
}) async {
  final supabase = Supabase.instance.client;

  var query = supabase.from('entity').select();

  if (districtId != null) {
    query = query.eq('district_id', districtId);
  }
  if (townIds != null && townIds.isNotEmpty) {
    query = query.inFilter('town_id', townIds);
  }

  final rows = await query;

  final entities = rows.map(Entity.from).toList();
  return entities;
}

Future<void> createEntity(Entity entity) async {
  final supabase = Supabase.instance.client;
  await supabase.from('entity').insert(entity.toJson());
}
