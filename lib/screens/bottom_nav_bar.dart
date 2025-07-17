import 'package:flutter/material.dart';
import '../screens/finance.dart'; // Assuming this is your HomePage
import '../screens/goals.dart'; // Adjust if filename is different

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget destination;
    switch (index) {
      case 0:
        destination = HomePage(); // Home screen from finance.dart
        break;
      case 1:
        destination = GoalsPage(); // Goals screen
        break;
      case 2:
        destination = ProfilePage() as Widget; // Placeholder for now
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.track_changes),
          label: 'Goals',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

class ProfilePage {}
