// lib/screens/community_screen.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/groups.dart';
import 'package:kuveni_app/screens/wellness.dart';
import 'package:kuveni_app/screens/helper_list_screen.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommunityButton(
              title: 'Groups',
              icon: Icons.group,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GroupsScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            CommunityButton(
              title: 'Wellness',
              icon: Icons.favorite,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WellnessScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            CommunityButton(
              title: 'Helpers',
              icon: Icons.people_alt,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpersListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CommunityButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CommunityButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: SizedBox(
          width: 200,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.purple[300]),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}