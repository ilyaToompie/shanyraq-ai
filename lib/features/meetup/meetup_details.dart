import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shyraq_ai/features/users/data/kazakhCities.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';
import 'package:shyraq_ai/shared/widgets/adaptive_dialogue.dart';
import 'package:shyraq_ai/shared/widgets/profile/profile_button.dart';

class MeetupDetailsScreen extends StatefulWidget {
  final LatLng location;
  final String organizerUid;
  final String title;
  final String description;
  final String city; // city key (e.g. 'almaty')
  final DateTime startDate;

  const MeetupDetailsScreen({
    super.key,
    required this.location,
    required this.organizerUid,
    required this.title,
    required this.description,
    required this.city,
    required this.startDate,
  });

  @override
  State<MeetupDetailsScreen> createState() => _MeetupDetailsScreenState();
}

class _MeetupDetailsScreenState extends State<MeetupDetailsScreen> {
  AppUser? organizer;

  @override
  void initState() {
    super.initState();
    fetchUserByUid(widget.organizerUid).then((user) {
      if (mounted) setState(() => organizer = user);
    });
  }

  String getCityName(String key, BuildContext context) {
    final lang = context.locale.languageCode;
    return kazakhstan_cities[key]?[lang] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat.yMMMMd(
      context.locale.toString(),
    ).add_Hm().format(widget.startDate);
    final cityName = getCityName(widget.city, context);

    return Scaffold(
      appBar: AppBar(title: Text('meetup.title'.tr())),
      body: Column(
        children: [
          SizedBox(
            height: 220,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: widget.location,
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: widget.location,
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(widget.description),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ProfileButton(user: organizer!),

                      const SizedBox(width: 6),
                      Text(organizer!.username),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 6),
                      Text(cityName),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(width: 6),
                      Text(dateStr),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      adaptiveDialog(
                        context: context,
                        title: 'Ошибка',
                        content:
                            "Вы не можете записаться на встечу из-за малого возраста аккаунта\nТак же необходимо привязать почту и номер телефона",
                      );
                    },
                    child: Text('meetup.sign_in'.tr()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
