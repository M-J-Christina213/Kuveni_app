import 'package:flutter/material.dart';
import './bottom_nav_bar.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        backgroundColor: Colors.deepPurple, // Optional: Customize color
      ),
      body: const Center(
        child: Text(
          'Jobs Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
      currentIndex: 1, // Jobs tab selected
      onTap: (index) {
        if (index == 1) return;
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/safety');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/finance');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/community');
            break;
        }
      },
    ),

    );
  }
}
