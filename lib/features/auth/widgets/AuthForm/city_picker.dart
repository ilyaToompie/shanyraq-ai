import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/users/data/kazakhCities.dart';

class CityPicker extends StatefulWidget {
  final String locale; // 'en', 'ru', or 'kk'
  final void Function(String cityCode) onSelected;

  const CityPicker({super.key, required this.locale, required this.onSelected});

  @override
  State<CityPicker> createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
  late String selectedCityCode;

  @override
  void initState() {
    super.initState();
    selectedCityCode = kazakhstanCities.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    final cityEntries = kazakhstanCities.entries.toList();

    return DropdownButtonFormField<String>(
      value: selectedCityCode,
      items:
          cityEntries
              .map(
                (entry) => DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.value[widget.locale] ?? entry.key),
                ),
              )
              .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedCityCode = value;
          });
          widget.onSelected(value);
        }
      },
      decoration: InputDecoration(
        labelText: 'City',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        labelStyle: const TextStyle(color: Colors.black),
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
      style: const TextStyle(fontSize: 16, color: Colors.black),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
    );
  }
}
