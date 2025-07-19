import 'package:flutter/material.dart';
import './bottom_nav_bar.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety')),
      body: const Center(child: Text('Safety Screen')),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/jobs');
          } else if (index == 2) {
            // Already in Safety
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
