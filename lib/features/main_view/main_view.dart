import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shyraq_ai/features/home/home_screen.dart';
import 'package:shyraq_ai/features/practice/practice_screen.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<Widget> _bottomNavBarScreens = <Widget>[
    const HomeScreen(),
    const Text('Likes'),
    const PracticeScreen(),
    const Text('Profile'),
    const Text('Profile'),
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
            padding: EdgeInsets.all(20),
            duration: Duration(milliseconds: 250),
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
                text: "Home",
              ),
              GButton(
                textStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                icon: Icons.school_rounded,
                text: "Learn",
              ),
              GButton(
                textStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                icon: Icons.sports_gymnastics,
                text: "Practice",
              ),
              GButton(
                textStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                icon: Icons.favorite_rounded,
                text: "Social",
              ),
              GButton(
                textStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                icon: Icons.people_rounded,
                text: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
