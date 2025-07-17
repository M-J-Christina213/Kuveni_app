import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'finance_screen.dart';
import 'community_screen.dart';
import 'safety_screen.dart';
import './bottom_nav_bar.dart'; 

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jobs')),
      body: const Center(child: Text('Jobs Screen')),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            // Already in Jobs
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/safety');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/finance');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/community');
          }
        },
      ),
    );
  }
}
