import 'package:flutter/material.dart';

class JobsMainDashboard extends StatelessWidget {
  const JobsMainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Hub'),
        backgroundColor: const Color(0xFF700DB2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Explore Opportunities',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            //  View Jobs Card
            _buildFeatureCard(
              context,
              title: 'View Jobs',
              description: 'Browse remote, part-time, verified jobs.',
              icon: Icons.work_outline,
              color: Colors.deepPurple,
              route: '/viewJobs',
            ),

            //  Premium Services
            _buildFeatureCard(
              context,
              title: 'Premium Services',
              description: 'Find top-rated cooks, tutors, nannies.',
              icon: Icons.star_border,
              color: Colors.pinkAccent,
              route: '/premiumServices',
            ),

            // Post Job
            _buildFeatureCard(
              context,
              title: 'Post a Job',
              description: 'Hire women workers directly from the app.',
              icon: Icons.post_add,
              color: Colors.teal,
              route: '/postJob',
            ),

            // Event Squad
            _buildFeatureCard(
              context,
              title: 'Event Squad',
              description: 'Get support team for big occasions.',
              icon: Icons.event,
              color: Colors.orange,
              route: '/eventSquadForm',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(description),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}