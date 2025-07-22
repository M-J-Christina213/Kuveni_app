import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/friendlist_screen.dart';
import 'package:kuveni_app/screens/groups.dart';
import 'package:kuveni_app/screens/helper_list_screen.dart';
import 'package:kuveni_app/screens/wellness.dart'; // Make sure this path is correct

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Community',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Join the Kuveni Community',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'Connect with others, share your journey, and grow together.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Cards Grid
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCommunityCard(
                  context,
                  icon: Icons.group,
                  title: 'Groups',
                  color: Colors.teal.shade100,
                  onTap: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GroupDetailScreen()),
                    );

                  },
                ),
                _buildCommunityCard(
                  context,
                  icon: Icons.volunteer_activism,
                  title: 'Helpers',
                  color: Colors.amber.shade100,
                  onTap: (

                  ) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpersListScreen()),
                  );
                  },
                ),
                _buildCommunityCard(
                  context,
                  icon: Icons.people,
                  title: 'Friends',
                  color: Colors.green.shade100,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FriendsListScreen()),
                    );
                  },
                ),
                _buildCommunityCard(
                  context,
                  icon: Icons.favorite,
                  title: 'Wellness',
                  color: Colors.purple.shade100,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WellnessScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for community cards
  Widget _buildCommunityCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.deepPurple),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}