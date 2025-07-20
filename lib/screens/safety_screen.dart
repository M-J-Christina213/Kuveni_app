// lib/screens/safety_screen.dart
import 'package:flutter/material.dart';
// import './bottom_nav_bar.dart'; // No longer needed as MainScreen manages the global one

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar with gradient background for consistency
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // Standard AppBar height
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF5902B1), // Deep Purple
                Color(0xFF700DB2), // Lighter Purple
                Color(0xFFF54DB8), // Pink
                Color(0xFFEBB41F), // Orange/Yellow
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Make AppBar background transparent
            elevation: 0, // Remove shadow
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context); // Navigate back (if pushed onto a stack)
              },
            ),
            title: const Text(
              'Safety',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true, // Center the title
            actions: [
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 30),
                onPressed: () {
                  // TODO: Navigate to profile screen
                  print('Profile icon tapped from Safety Screen');
                },
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Safety Screen Content will go here.',
          style: TextStyle(fontSize: 20),
        ),
      ),
      // IMPORTANT: Removed the BottomNavBar from here.
      // The main BottomNavBar is controlled by MainScreen.
    );
  }
}
