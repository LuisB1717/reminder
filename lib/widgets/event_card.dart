import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/core/event.dart';
import 'package:reminder/resources/colors.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yy').format(event.date);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.entity!['name'],
            style: const TextStyle(fontSize: 16),
          ),
          Text(event.entity!['address'], style: TextStyle(fontSize: 12)),
          Text(
            event.type == "0" ? "Cumpleaños" : "Aniversario",
            style: TextStyle(fontSize: 12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                dateFormat,
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
