import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:shyraq_ai/features/meetup/meetup_details.dart';
import 'package:shyraq_ai/features/users/data/kazakhCities.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';

import 'package:shyraq_ai/shared/widgets/profile/profile_button.dart';

class MeetupCard extends StatefulWidget {
  final LatLng location;
  final String organizerUid;
  final String title;
  final String description;
  final String city; // e.g. 'almaty'
  final DateTime startDate;

  const MeetupCard({
    super.key,
    required this.location,
    required this.organizerUid,
    required this.title,
    required this.description,
    required this.city,
    required this.startDate,
  });

  @override
  State<MeetupCard> createState() => _MeetupCardState();
}

class _MeetupCardState extends State<MeetupCard> {
  String? organizerUsername;
  AppUser? organizer;
  @override
  void initState() {
    super.initState();
    fetchUserByUid(widget.organizerUid).then((user) {
      if (mounted && user != null) {
        setState(() {
          organizerUsername = user.username;
        });
      }
      fetchUserByUid(widget.organizerUid).then((user) {
        if (mounted && user != null) {
          setState(() {
            organizerUsername = user.username;
            organizer = user;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final date = DateFormat.yMMMd(
      context.locale.toString(),
    ).format(widget.startDate);
    final time = DateFormat.Hm(
      context.locale.toString(),
    ).format(widget.startDate);
    final cityName =
        kazakhstan_cities[widget.city]?[context.locale.languageCode] ??
        widget.city;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (_) => MeetupDetailsScreen(
                  location: widget.location,
                  organizerUid: widget.organizerUid,
                  title: widget.title,
                  description: widget.description,
                  city: widget.city,
                  startDate: widget.startDate,
                ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(20),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            Icon(Icons.group, color: color.onSurfaceVariant),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: color.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'meetup_date'.tr(args: [date]),
                    style: TextStyle(color: color.onSurfaceVariant),
                  ),
                  Text(
                    'meetup_time'.tr(args: [time]),
                    style: TextStyle(color: color.onSurfaceVariant),
                  ),
                  Text(
                    'meetup_city'.tr(args: [cityName]),
                    style: TextStyle(color: color.onSurfaceVariant),
                  ),
                  if (organizerUsername != null)
                    Row(
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: ProfileButton(user: organizer),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'meetup_organizer'.tr(args: [organizerUsername!]),
                          style: TextStyle(color: color.onSurfaceVariant),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(size: 32, Icons.chevron_right_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
