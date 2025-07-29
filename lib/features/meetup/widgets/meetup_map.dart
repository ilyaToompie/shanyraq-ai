import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MeetupMap extends StatelessWidget {
  static const _center = LatLng(45.0156, 78.3739);
  const MeetupMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: FlutterMap(
          options: const MapOptions(initialCenter: _center, initialZoom: 13.0),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.yourapp',
            ),
            const MarkerLayer(
              markers: [
                Marker(
                  width: 40,
                  height: 40,
                  point: _center,
                  child: const Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
