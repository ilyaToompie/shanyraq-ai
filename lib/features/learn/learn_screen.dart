import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/learn/widgets/lessons_map_widget.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text("Learn", style: TextStyle(fontSize: 42)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text("Today's plan", style: TextStyle(fontSize: 48)),
            Text(
              "Look, we've selected lessons specialy for You!",
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withAlpha(150),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 2,
              child: ListView(children: [
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
