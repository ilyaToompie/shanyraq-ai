import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  Locale? _selectedLocale;

  final Map<Locale, String> flags = {
    const Locale('kk'): '🇰🇿',
    const Locale('ru'): '🇷🇺',
    const Locale('en'): '🇬🇧',
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLocale ??= context.locale;
  }

  void _onLanguageTap(Locale locale) {
    setState(() {
      _selectedLocale = locale;
    });
    context.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  flags.entries.map((entry) {
                    final isSelected = entry.key == _selectedLocale;
                    return GestureDetector(
                      onTap: () => _onLanguageTap(entry.key),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.grey,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 48),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 40),
            Text(
              _selectedLocale == null
                  ? 'please_select_language'.tr()
                  : '${'selected'.tr()}: ${flags[_selectedLocale]!}',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed:
                  _selectedLocale == null
                      ? null
                      : () => Navigator.of(context).pop(),
              child: const Text('confirm').tr(),
            ),
          ],
        ),
      ),
    );
  }
}
