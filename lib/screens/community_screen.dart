// lib/screens/community_screen.dart
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget { // Changed to StatelessWidget
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No AppBar here, as the MainScreen Scaffold might provide one,
      // or you can add a custom one if this screen needs a unique header.
      // For now, let's assume the gradient top bar is handled by MainScreen or a custom widget.
      body: SingleChildScrollView( // Prevents overflow
        child: Column(
          children: <Widget>[
            // Header Section - Assuming background_image.png is in assets/
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient( // Added gradient to match app theme
                  colors: [
                    Color(0xFF5902B1), // Deep Purple
                    Color(0xFF700DB2), // Lighter Purple
                    Color(0xFFF54DB8), // Pink
                    Color(0xFFEBB41F), // Orange/Yellow
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                // image: DecorationImage( // If you want an image, ensure it's in assets and uncomment
                //   image: AssetImage('assets/background_image.png'),
                //   fit: BoxFit.cover,
                // ),
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
            _buildFeatureButton(context, "GROUPS", Icons.group),
            _buildFeatureButton(context, "WELLNESS", Icons.health_and_safety),
            _buildFeatureButton(context, "HELPERS", Icons.support),
          ],
        ),
      ),
      // IMPORTANT: Removed the BottomNavigationBar from here.
      // The main BottomNavBar is controlled by MainScreen.
    );
  }

  // Reusable feature button builder
  Widget _buildFeatureButton(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          // Handle navigation or action for this feature
          // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => const GroupsScreen()));
          print('$title button pressed');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple, // Button color
          padding: const EdgeInsets.symmetric(vertical: 20), // Use const
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Added rounded corners
          ),
          elevation: 5, // Added subtle shadow
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
