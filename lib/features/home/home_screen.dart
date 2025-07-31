import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/home/widgets/home_screen_title.dart';
import 'package:shyraq_ai/features/home/widgets/more_details_button.dart';
import 'package:shyraq_ai/features/home/widgets/progress_widget.dart';
import 'package:shyraq_ai/features/home/widgets/results_widget.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';
import 'package:shyraq_ai/shared/widgets/profile/profile_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadUser(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                actions: [
                  ProfileButton(user: (user != null) ? user : null),
                  const SizedBox(width: 16),
                ],
                title: Text(
                  user != null
                      ? "salem-title".tr(args: [user.username])
                      : "salem-title".tr(args: ['guest'.tr()]),
                  style: const TextStyle(fontSize: 30),
                ),
                centerTitle: false,
              ),
              body: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: HomeScreenTitle(),
                  ),
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 128.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      spacing: 32,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 14.0,
                            bottom: 16,
                          ),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text("50", style: TextStyle(fontSize: 48)),
                                  SizedBox(width: 8),
                                  Text("/ 100", style: TextStyle(fontSize: 33)),
                                ],
                              ),
                              Text(
                                "you-recent-score".tr(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const MoreDetailsButton(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProgressWidget(
                          icon: Icons.school_rounded,
                          title: 'topics'.tr(),
                          max: 8,
                          completed: 2,
                        ),
                        SizedBox(width: 12),
                        ProgressWidget(
                          icon: Icons.warning_amber_rounded,
                          title: 'questions'.tr(),
                          max: 21,
                          completed: 2,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ResultsWidget(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
