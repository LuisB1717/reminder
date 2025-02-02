import 'package:reminder/core/entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Entity>> getEntities({
  String? districtId,
  List<int>? townIds,
}) async {
  final supabase = Supabase.instance.client;

  var query = supabase
      .from('entity')
      .select(' * , town ( id, name ), district (id , name ) ');

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

Future<int> getCountEntities() async {
  final supabase = Supabase.instance.client;
  final response = await supabase.from("entity").count();
  return response;
}

Future<void> createEntity(Entity entity) async {
  final supabase = Supabase.instance.client;
  await supabase.from('entity').insert(entity.toJson());
}

Future<void> deleteEntity(Entity entity) async {
  final supabase = Supabase.instance.client;
  await supabase.from('entity').delete().eq('id', entity.id!);
}
