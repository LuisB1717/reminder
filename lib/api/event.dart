import 'package:reminder/core/event.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Event>> getAllEvents() async {
  final supabase = Supabase.instance.client;
  final rows = await supabase.from('event').select();
  final events = rows.map(Event.from).toList();

  return events;
}
