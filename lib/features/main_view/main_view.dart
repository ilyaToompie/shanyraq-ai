import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shyraq_ai/features/home/home_screen.dart';
import 'package:shyraq_ai/features/learn/learn_screen.dart';
import 'package:shyraq_ai/features/practice/presentation/practice_setup_screen/practice_setup_screen.dart';
import 'package:shyraq_ai/features/social/social_screen.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<Widget> _bottomNavBarScreens = <Widget>[
    const HomeScreen(),
    const LearnScreen(),
    const PracticeSetupScreen(),
    const SocialScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(child: _bottomNavBarScreens.elementAt(_selectedIndex)),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(48),
          child: GNav(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            duration: const Duration(milliseconds: 250),
            gap: 8,
            backgroundColor: Theme.of(context).primaryColor,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              GButton(
                textStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                icon: Icons.home_rounded,
                text: "home".tr(),
              ),
              GButton(
                textStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                icon: Icons.school_rounded,
                text: "learn".tr(),
              ),
              GButton(
                textStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                icon: Icons.sports_gymnastics,
                text: "practice".tr(),
              ),
              GButton(
                textStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                icon: Icons.favorite_rounded,
                text: "social".tr(),
              ),
              /*GButton(
                textStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                icon: Icons.people_rounded,
                text: "Profile",
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
