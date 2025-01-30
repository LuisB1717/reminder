import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/core/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final dateFormat = DateFormat('dd/MM/yy').format(event.date);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.entity!['name'],
            style: TextStyle(fontSize: 16, color: colorScheme.onSecondary),
          ),
          const SizedBox(height: 3.0),
          Text(
            event.entity!['address'],
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSecondary.withAlpha(150),
            ),
          ),
          const SizedBox(height: 3.0),
          Text(
            event.type == "0" ? "Cumpleaños" : "Aniversario",
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSecondary.withAlpha(100),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                dateFormat,
                style: TextStyle(fontSize: 12, color: colorScheme.primary),
              )
            ],
          )
        ],
      ),
    );
  }
}
