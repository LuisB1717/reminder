import 'package:reminder/core/event.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Event>> getAllEvents() async {
  final supabase = Supabase.instance.client;
  final rows = await supabase.from('event').select(' * , entity (*) ');
  final events = rows.map(Event.from).toList();

  return events;
}

Future<void> createEvent(Event event) async {
  final supabase = Supabase.instance.client;
  await supabase.from('event').insert(event.toJson());
}

Future<void> deleteEvent(String entityId) async {
  final supabase = Supabase.instance.client;
  await supabase.from('event').delete().eq('entity_id', entityId);
}

Future<void> updateEvent(String entityId, DateTime date) async {
  final supabase = Supabase.instance.client;
  await supabase
      .from('event')
      .update({'date': date.toIso8601String()}).eq('entity_id', entityId);
}
