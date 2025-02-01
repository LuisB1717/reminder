import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/core/event.dart';
import 'package:reminder/resources/strings.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final dateFormat =
        DateFormat("EE, dd 'de' MMMM", "es_PE").format(event.date);

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
            event.entity!.name,
            style: TextStyle(fontSize: 16, color: colorScheme.onSecondary),
          ),
          const SizedBox(height: 3.0),
          Text(
            event.entity!.address.isNotEmpty
                ? event.entity!.address
                : Strings.noAddress,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSecondary.withAlpha(150),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                event.type == "0"
                    ? Icons.cake_rounded
                    : Icons.card_giftcard_rounded,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8.0),
              Text(
                dateFormat.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.primary,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
