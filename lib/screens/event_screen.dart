import 'package:flutter/material.dart';
import 'package:reminder/api/event.dart';
import 'package:reminder/core/event.dart';
import 'package:reminder/widgets/event_card.dart';
import 'package:reminder/resources/strings.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Strings.reminders,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder(
        future: getAllEvents(),
        builder: (context, snapshot) {
          return EventList(events: snapshot.data ?? []);
        },
      ),
    );
  }
}

class EventList extends StatelessWidget {
  const EventList({
    super.key,
    required this.events,
  });

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final currentEvent = events[index];
        final previousEvent = index - 1 < 0 ? null : events[index - 1];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (currentEvent.date.day != previousEvent?.date.day)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 26.0,
                  vertical: 8.0,
                ),
                child: Text(
                  _toDayName(
                    currentEvent.date,
                  ),
                  style: TextStyle(fontSize: 14),
                ),
              ),
            EventCard(event: currentEvent),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8.0);
      },
    );
  }
}

_toDayName(DateTime date) {
  final now = DateTime.now();
  final difference = date.difference(now).inDays;

  if (difference == 0) return Strings.today;
  if (difference == 1) return Strings.tomorrow;
  return 'En $difference dias';
}
