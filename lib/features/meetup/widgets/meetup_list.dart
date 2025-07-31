import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:shyraq_ai/features/meetup/widgets/meetup_card.dart';

class MeetupList extends StatelessWidget {
  const MeetupList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MeetupCard(
          location: LatLng(43.238949, 76.889709),
          organizerUid: 'Zd57h3wJDwcE59fX7thC68wcudw2',
          title: 'Разговорная практика на казахском',
          description: 'Прокачай навыки устной речи с носителями языка.',
          city: 'almaty',
          startDate: DateTime(2025, 8, 1, 18, 0),
        ),
        const SizedBox(height: 12),
        MeetupCard(
          location: LatLng(51.1605, 71.4704),
          organizerUid: 'tcwtGKIDa2b7rtW0TPcUgJuQJbE3',
          title: 'Мастер-класс по грамматике',
          description:
              'Подробный разбор грамматических правил казахского языка.',
          city: 'nur_sultan',
          startDate: DateTime(2025, 8, 2, 17, 30),
        ),
        const SizedBox(height: 12),
        MeetupCard(
          location: LatLng(42.3417, 69.5901),
          organizerUid: '44XFJXl1OSV1NUbbNKjoxt7v8zu2',
          title: 'Спринт по лексике казахского',
          description: 'Расширяй словарный запас с помощью игровых заданий.',
          city: 'shymkent',
          startDate: DateTime(2025, 8, 3, 16, 0),
        ),
      ],
    );
  }
}
