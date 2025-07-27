import 'package:flutter/material.dart';

class OverallScoreInfo extends StatelessWidget {
  const OverallScoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 65.0, vertical: 2),
            child: Text('Your chat score:', style: TextStyle(fontSize: 24)),
          ),
          SizedBox(width: 60, child: Divider()),
          Text('Accuracy: 2.4'),
          Text('Content: 4.9'),
          Text('Interaction: 3.4'),
          SizedBox(width: 60, child: Divider()),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'AI rates your…\n 1. Content - how well you cover the topic\n2. Accuracy - grammar and language quality\n3. Interaction - engagement and logical flow',
            ),
          ),
        ],
      ),
    );
  }
}
