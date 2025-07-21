// lib/screens/job_huntlist.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/view_jobhunt.dart'; // IMPORTANT: Import the ViewJobVacancyScreen

class JobHuntListScreen extends StatefulWidget {
  const JobHuntListScreen({super.key});

  @override
  State<JobHuntListScreen> createState() => _JobHuntListScreenState();
}

class _JobHuntListScreenState extends State<JobHuntListScreen> {
  // Placeholder list of job data (you'll fetch this from Firebase later)
  final List<Map<String, String>> _jobListings = [
    {
      'jobTitle': 'Event Coordinator Assistant',
      'company': 'Dream Events Ltd.',
      'location': 'Colombo',
      'salary': 'LKR 4500/day',
      'description': 'Assist in planning and executing various events. Good communication skills required.',
    },
    {
      'jobTitle': 'Part-time Tutor (Math)',
      'company': 'Private Client',
      'location': 'Kandy',
      'salary': 'LKR 2500/hour',
      'description': 'Looking for a qualified tutor for O/L students. Flexible hours.',
    },
    {
      'jobTitle': 'Data Entry Clerk',
      'company': 'ABC Solutions',
      'location': 'Online',
      'salary': 'LKR 20000/month',
      'description': 'Remote position for accurate data entry. Basic computer skills essential.',
    },
    {
      'jobTitle': 'House Sitter',
      'company': 'Individual Client',
      'location': 'Galle',
      'salary': 'LKR 3000/day',
      'description': 'Responsible individual needed to look after house and pets while owner is away.',
    },
    {
      'jobTitle': 'Graphic Designer (Freelance)',
      'company': 'Creative Hub',
      'location': 'Remote',
      'salary': 'Negotiable per project',
      'description': 'Seeking creative graphic designers for various projects. Portfolio required.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar with gradient background
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
                Navigator.pop(context); // Navigate back to JobsMainDashboard
              },
            ),
            title: const Text(
              'Job Hunt',
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
                  print('Profile icon tapped from Job Hunt List');
                },
              ),
            ],
          ),
        ),
      ),
      body: _jobListings.isEmpty
          ? const Center(
              child: Text(
                'No job listings available yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _jobListings.length,
              itemBuilder: (context, index) {
                final job = _jobListings[index];
                return _buildJobCard(
                  context,
                  jobTitle: job['jobTitle']!,
                  company: job['company']!,
                  location: job['location']!,
                  salary: job['salary']!,
                  description: job['description']!,
                );
              },
            ),
    );
  }

  // Helper widget for a single job card (reused from JobsMainDashboard)
  Widget _buildJobCard(
    BuildContext context, {
    required String jobTitle,
    required String company,
    required String location,
    required String salary,
    required String description,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          // Navigate to ViewJobVacancyScreen, passing job details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewJobVacancyScreen(
                jobTitle: jobTitle,
                company: company,
                location: location,
                salary: salary,
                description: description,
                // You can pass more details here if your ViewJobVacancyScreen needs them
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '$company - $location',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 5),
              Text(
                salary,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    // Navigate to ViewJobVacancyScreen when "View Details" is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewJobVacancyScreen(
                          jobTitle: jobTitle,
                          company: company,
                          location: location,
                          salary: salary,
                          description: description,
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  child: const Text('View Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
