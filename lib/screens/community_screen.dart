// full code below
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// Make sure this exists and is properly configured

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _selectedIndex = 3; // Default to Community tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Example navigation (You can adjust this based on your app structure)
    switch (index) {
      case 0:
        // Navigator.pushNamed(context, '/home');
        break;
      case 1:
        // Navigator.pushNamed(context, '/jobs');
        break;
      case 2:
        // Navigator.pushNamed(context, '/finance');
        break;
      case 3:
        // Already on Community
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Prevents overflow
        child: Column(
          children: <Widget>[
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100), // Push text down over image
                  const Text(
                    'Your Community Space !!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '“Connect, share & grow together.”',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50), // Padding at bottom of banner
                ],
              ),
            ),

            const SizedBox(height: 20), // Spacing

            // Feature Buttons
            _buildFeatureButton("GROUPS", Icons.group),
            _buildFeatureButton("WELLNESS", Icons.health_and_safety),
            _buildFeatureButton("HELPERS", Icons.support),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Finance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Community',
          ),
        ],
      ),
    );
  }

  // Reusable feature button builder
  Widget _buildFeatureButton(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          // Handle navigation or action for this feature
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple, // Button color
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
