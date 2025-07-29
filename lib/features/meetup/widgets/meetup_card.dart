import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MeetupCard extends StatelessWidget {
  final int current;
  final int max;
  final String time;
  final String date;
  final String bossUsername;

  const MeetupCard({
    required this.current,
    required this.max,
    required this.time,
    required this.date,
    required this.bossUsername,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(Icons.group, color: color.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "people-range".tr(args: [current.toString(), max.toString()]),
                  style: TextStyle(color: color.onSurfaceVariant),
                ),
                Text(
                  'time'.tr(args: [time]),
                  style: TextStyle(color: color.onSurfaceVariant),
                ),
                Text(
                  'date'.tr(args: [date]),
                  style: TextStyle(color: color.onSurfaceVariant),
                ),
                Text(
                  'organizer'.tr(args: [bossUsername]),
                  style: TextStyle(color: color.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
