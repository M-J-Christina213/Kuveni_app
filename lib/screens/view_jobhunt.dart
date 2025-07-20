// lib/screens/view_jobhunt.dart
import 'package:flutter/material.dart';

class ViewJobVacancyScreen extends StatelessWidget {
  // These are the parameters that will be passed from JobHuntListScreen
  final String jobTitle;
  final String company;
  final String location;
  final String salary;
  final String description;
  // You can add more fields here if your job model expands (e.g., requirements, postedDate)

  const ViewJobVacancyScreen({
    super.key,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.salary,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
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
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context); // Navigate back to JobHuntListScreen
              },
            ),
            title: Text(
              jobTitle, // Display the job title in the app bar
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 30),
                onPressed: () {
                 
                  'Profile icon tapped from View Job Vacancy';
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView for longer content
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobTitle,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 8),
            Text(
              '$company - $location',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              salary,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green),
            ),
            const SizedBox(height: 16),
            const Text(
              'Job Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            // For example:
            // const SizedBox(height: 16),
            // const Text(
            //   'Responsibilities:',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 8),
            // Text(
            //   '• Manage daily tasks\n• Communicate with clients', // Example hardcoded
            //   style: const TextStyle(fontSize: 16, height: 1.5),
            // ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                 
                  'Apply button tapped for: $jobTitle';
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Apply functionality coming soon!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5902B1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Apply Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
