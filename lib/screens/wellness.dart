// lib/screens/wellnesss.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/profile_screen.dart'; // IMPORTANT: Import ProfileScreen
import 'package:kuveni_app/screens/session.dart'; 
// You might also want to import other screens like meditation, articles, etc.

class WellnessScreen extends StatelessWidget {
  const WellnessScreen({super.key});

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
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Wellness Hub', // Changed title to be more descriptive
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to your Wellness Journey!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              'Explore resources to support your mental and emotional well-being.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 25),

            // Section 1: Quick Access Cards
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              shrinkWrap: true, // Important for GridView inside SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
              children: [
                _buildWellnessCard(
                  context,
                  icon: Icons.self_improvement,
                  title: 'Meditation & Mindfulness',
                  color: Colors.lightBlue.shade100,
                  onTap: () {
                  ('Meditation & Mindfulness tapped');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Meditation content coming soon!')),
                    );
                    
                  },
                ),
                _buildWellnessCard(
                  context,
                  icon: Icons.article,
                  title: 'Articles & Insights',
                  color: Colors.green.shade100,
                  onTap: () {
                    ('Articles & Insights tapped');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Wellness articles coming soon!')),
                    );
                    
                  },
                ),
                _buildWellnessCard(
                  context,
                  icon: Icons.event,
                  title: 'Upcoming Sessions',
                  color: Colors.orange.shade100,
                  onTap: () {
                    ('Upcoming Sessions tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SessionScreen()), // Navigate to SessionScreen
                    );
                  },
                ),
                _buildWellnessCard(
                  context,
                  icon: Icons.sentiment_satisfied_alt,
                  title: 'Mood Tracker',
                  color: Colors.purple.shade100,
                  onTap: () {
                    ('Mood Tracker tapped');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mood Tracker coming soon!')),
                    );
                   
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Section 2: Featured Content/Tips
            const Text(
              'Daily Wellness Tip',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Practice gratitude daily!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.deepPurple[700]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Take a few moments each day to think about things you are grateful for. This simple practice can significantly boost your mood and overall well-being.',
                      style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          ('Learn more about gratitude');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('More tips coming soon!')),
                          );
                        },
                        child: const Text('Learn More', style: TextStyle(color: Color(0xFF700DB2))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Section 3: Quick Links (e.g., to professional help)
            const Text(
              'Need Professional Help?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () {
                  ('Find a Therapist/Counselor tapped');
                 
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Finding professionals coming soon!')),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.psychology, size: 30, color: Colors.blue),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          'Find a Therapist or Counselor',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper method to build consistent wellness cards
  Widget _buildWellnessCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: color,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.deepPurple.shade700),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}