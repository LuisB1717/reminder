import 'package:flutter/material.dart';
import 'package:reminder/core/entity.dart';

class EntityCard extends StatefulWidget {
  final Entity entity;
  final Function() onDelete;
  const EntityCard({
    super.key,
    required this.entity,
    required this.onDelete,
  });

  @override
  State<EntityCard> createState() => _EntityCardState();
}

class _EntityCardState extends State<EntityCard> {
  double _scale = 1.0;
  @override
  Widget build(BuildContext context) {
    void onLongPressStart(LongPressStartDetails details) {
      setState(() {
        _scale = 0.92;
      });
    }

    void onLongPressEnd(LongPressEndDetails details) {
      setState(() {
        _scale = 1.0;
      });

      widget.onDelete();
    }

    return GestureDetector(
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 8.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.entity.name,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              const SizedBox(height: 3.0),
              Text(
                widget.entity.phone!,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      Theme.of(context).colorScheme.onSecondary.withAlpha(150),
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                widget.entity.address,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      Theme.of(context).colorScheme.onSecondary.withAlpha(100),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.entity.town == null
                        ? widget.entity.district.toString()
                        : '${widget.entity.town}, ${widget.entity.district}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
