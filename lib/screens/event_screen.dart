import 'package:flutter/material.dart';
import 'package:reminder/api/event.dart';
import 'package:reminder/core/event.dart';
import 'package:reminder/resources/strings.dart';
import 'package:reminder/widgets/event_card.dart';

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
          child: Row(
            children: [
              Text(
                Strings.reminders,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
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
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final maxDate = today.add(Duration(days: 3));

    final filteredEvents = events
        .where((event) =>
            event.date.isAfter(today.subtract(Duration(days: 1))) &&
            event.date.isBefore(maxDate.add(Duration(days: 1))))
        .toList();

    final sortedEvents = filteredEvents
      ..sort((a, b) => a.date.compareTo(b.date));

    if (sortedEvents.isEmpty) {
      return Center(
        child: Text(
          Strings.emptyEvent,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: sortedEvents.length,
      itemBuilder: (context, index) {
        final currentEvent = sortedEvents[index];
        final previousEvent = index - 1 < 0 ? null : sortedEvents[index - 1];
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
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            EventCard(event: currentEvent),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20.0);
      },
    );
  }
}

_toDayName(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final difference = date.difference(today).inDays;

  if (difference == 0) return Strings.today;
  if (difference == 1) return Strings.tomorrow;
  return 'En $difference dias';
}
