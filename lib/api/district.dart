import 'package:reminder/core/district.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<District>> getDistricts() async {
  final supabase = Supabase.instance.client;
  final rows = await supabase.from('district').select().eq('province_id', 1304);
  final districts = rows.map(District.from).toList();

  return districts;
}
