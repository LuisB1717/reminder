import 'package:reminder/core/event.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Event>> getAllEvents() async {
  final events = await Supabase.instance.client.from('event').select();
  return events.map((event) => Event.from(event)).toList();
}
