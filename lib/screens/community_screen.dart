import 'package:flutter/material.dart';
import './bottom_nav_bar.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community')),
      body: const Center(child: Text('Community Screen')),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 4,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/jobs');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/safety');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/finance');
          } else if (index == 4) {
            // Already in Community
          }
        },
      ),

      //start from here 
    );
  }
}
