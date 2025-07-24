import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/home/widgets/home_screen_title.dart';
import 'package:shyraq_ai/features/home/widgets/more_details_button.dart';
import 'package:shyraq_ai/features/home/widgets/progress_widget.dart';
import 'package:shyraq_ai/features/home/widgets/results_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Salem,\n#username!"),
            centerTitle: false,
          ),
          body: const Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: HomeScreenTitle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 128.0),
                child: Divider(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  spacing: 64,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24.0, bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("?", style: TextStyle(fontSize: 48)),
                              SizedBox(width: 8),
                              Text("/ 100", style: TextStyle(fontSize: 33)),
                            ],
                          ),
                          Text(
                            "Your recent score",
                            style: TextStyle(fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ),
                    MoreDetailsButton(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProgressWidget(
                    icon: Icons.school_rounded,
                    title: 'Topics',
                    max: 8,
                    completed: 2,
                  ),
                  SizedBox(width: 12),
                  ProgressWidget(
                    icon: Icons.question_mark_rounded,
                    title: 'questions',
                    max: 8,
                    completed: 2,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(16.0), child: ResultsWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
