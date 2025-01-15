import 'package:reminder/core/town.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Town>> getTowns(int id) async {
  final supabase = Supabase.instance.client;
  final rows = await supabase.from('town').select().eq('district_id', id);
  final towns = rows.map(Town.from).toList();
  return towns;
}
