import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LegalDisclaimerWidget extends StatelessWidget {
  const LegalDisclaimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.surfaceVariant.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        'meetup_disclaimer'.tr(),
        style: TextStyle(color: color.onSurfaceVariant, fontSize: 14),
      ),
    );
  }
}
