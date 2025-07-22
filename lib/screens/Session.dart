// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/profile_screen.dart'; // IMPORTANT: Import ProfileScreen

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // Consistent AppBar height
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF5902B1),
                Color(0xFF700DB2),
                Color(0xFFF54DB8),
                Color(0xFFEBB41F),
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
                Navigator.pop(context); // Navigate back
              },
            ),
            title: const Text(
              'Sessions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              // Profile Icon - Now functional
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Session details will be displayed here.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
