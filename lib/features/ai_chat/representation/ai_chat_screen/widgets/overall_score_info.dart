import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OverallScoreInfo extends StatelessWidget {
  const OverallScoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 65.0, vertical: 2),
            child: Text(
              textAlign: TextAlign.center,
              'chat_score_title'.tr(),
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: 60, child: Divider()),
          Text('${'accuracy'.tr()}: 2.4'),
          Text('${'content'.tr()}: 4.9'),
          Text('${'interaction'.tr()}: 3.4'),
          const SizedBox(width: 60, child: Divider()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('chat_score_description'.tr()),
          ),
        ],
      ),
    );
  }
}
