import 'package:flutter/material.dart';
import 'package:reminder/core/entity.dart';
import 'package:reminder/resources/colors.dart';

class EntityCard extends StatelessWidget {
  final Entity entity;
  const EntityCard({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entity.name, style: TextStyle(fontSize: 16)),
          const SizedBox(height: 3.0),
          Text(entity.phone!, style: TextStyle(fontSize: 12)),
          const SizedBox(height: 3.0),
          Text(entity.address, style: TextStyle(fontSize: 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                entity.town == null
                    ? '${entity.district}'
                    : '${entity.town}, ${entity.district}',
                style: TextStyle(fontSize: 12, color: AppColors.button),
              )
            ],
          ),
        ],
      ),
    );
  }
}
