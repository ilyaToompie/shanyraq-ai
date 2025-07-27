import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showAlmatyLeaderboard = true;

  final List<String> friends = ['Aruzhan', 'Dias', 'Alisher', 'Zhanel'];

  final List<Map<String, dynamic>> almatyLeaderboard = [
    {'name': 'Erzat', 'xp': 1520},
    {'name': 'Nurik', 'xp': 1490},
    {'name': 'Aliya', 'xp': 1420},
  ];

  final List<Map<String, dynamic>> kazakhstanLeaderboard = [
    {'name': 'Samat', 'xp': 2100},
    {'name': 'Dana', 'xp': 2020},
    {'name': 'Timur', 'xp': 2000},
  ];

  @override
  Widget build(BuildContext context) {
    final currentLeaderboard =
        showAlmatyLeaderboard ? almatyLeaderboard : kazakhstanLeaderboard;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildAvatarSection(),
            const SizedBox(height: 24),
            _buildFriendsSection(),
            const SizedBox(height: 24),
            _buildLeaderboardToggle(),
            const SizedBox(height: 12),
            _buildLeaderboard(currentLeaderboard),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/avatar.png'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Your Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('XP: 1280'),
          ],
        ),
      ],
    );
  }

  Widget _buildFriendsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Friends',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: friends.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(friends[index])),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildToggleButton('Almaty', true),
        const SizedBox(width: 12),
        _buildToggleButton('Kazakhstan', false),
      ],
    );
  }

  Widget _buildToggleButton(String title, bool isAlmaty) {
    final isSelected = (showAlmatyLeaderboard == isAlmaty);
    return ElevatedButton(
      onPressed: () {
        setState(() {
          showAlmatyLeaderboard = isAlmaty;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(title),
    );
  }

  Widget _buildLeaderboard(List<Map<String, dynamic>> data) {
    return Expanded(
      child: ListView.separated(
        itemCount: data.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final user = data[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
            title: Text(user['name']),
            trailing: Text('${user['xp']} XP'),
          );
        },
      ),
    );
  }
}
