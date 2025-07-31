import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/meetup/widgets/meetup_intro_text.dart';
import 'package:shyraq_ai/features/meetup/widgets/meetup_list.dart';
import 'package:shyraq_ai/features/meetup/widgets/meetup_map.dart';
import 'package:shyraq_ai/features/meetup/widgets/meetup_title.dart';
import 'package:shyraq_ai/features/meetup/widgets/legal_disclaimer_widget.dart';

class MeetupsListScreen extends StatefulWidget {
  const MeetupsListScreen({super.key});

  @override
  State<MeetupsListScreen> createState() => _MeetupsListScreenState();
}

class _MeetupsListScreenState extends State<MeetupsListScreen> {
  bool showDisclaimer = false;

  void toggleDisclaimer() {
    setState(() => showDisclaimer = !showDisclaimer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('meetups-title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.error_outline_rounded, size: 32),
            onPressed: toggleDisclaimer,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          const SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MeetupIntroText(),
                SizedBox(height: 16),
                MeetupMap(),
                SizedBox(height: 24),
                MeetupTitle(),
                SizedBox(height: 12),
                MeetupList(),
              ],
            ),
          ),
          if (showDisclaimer)
            Positioned.fill(
              child: GestureDetector(
                onTap: toggleDisclaimer,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(24),
                  child: Material(
                    borderRadius: BorderRadius.circular(32),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: LegalDisclaimerWidget(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
