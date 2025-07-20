// lib/screens/jobs_main_dashboard.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/post_job.dart';
//import 'package:kuveni_app/screens/event_squad.dart';
//import 'package:kuveni_app/screens/job_huntlist.dart';
import 'package:kuveni_app/screens/premium_servicelist.dart';
import 'package:kuveni_app/screens/checkout.dart'; // Import for direct Checkout navigation
import 'package:kuveni_app/screens/view_jobhunt.dart'; // Import for _buildJobCard preview

class JobsMainDashboard extends StatefulWidget {
  const JobsMainDashboard({super.key});

  @override
  State<JobsMainDashboard> createState() => _JobsMainDashboardState();
}

class _JobsMainDashboardState extends State<JobsMainDashboard> {
  // Controller for the search text field
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar with gradient background
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0), // Increased height for search bar
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
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Placeholder for back button or app logo/title if needed
                    const Text(
                      'Job Dashboard', // Or your app's logo/name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Profile Icon
                    IconButton(
                      icon: const Icon(Icons.person, color: Colors.white, size: 30),
                      onPressed: () {                    
                        'Profile icon tapped';
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Search Bar
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for jobs...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      border: InputBorder.none, // Remove default border
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    onSubmitted: (query) {
                     
                      'Search query: $query';
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Post a Job" Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostJobScreen()),
                  );
                },
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.add_circle_outline, size: 40, color: Colors.deepPurple[400]),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Post a Job',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Reach out to thousands of helpers!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),

            // "Event Squad Form" Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () {
                 // Navigator.push(
                  //  context,
                  //  MaterialPageRoute(builder: (context) => const EventSquadScreen()),
                 // );
                },
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.event_note, size: 40, color: Colors.orange[400]),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Event Squad Form',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Request helpers for your events!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),

            // "Job Hunt" Section (View All Jobs)
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () {
                  //Navigator.push(
                   // context,
                   // MaterialPageRoute(builder: (context) => const JobHuntListScreen()),
                  //);
                },
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.search_rounded, size: 40, color: Colors.blue[400]),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Job Hunt',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Explore available job vacancies!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),

            // "Premium Services" Section (leads to list of services)
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PremiumServiceListScreen()),
                  );
                },
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.workspace_premium, size: 40, color: Colors.amber[700]),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Premium Services',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Discover exclusive helper services!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),

            // "Buy Premium Directly" Section (leads directly to checkout)
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                  );
                },
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart, size: 40, color: Colors.pink[400]),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Buy Premium Now',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Access all premium features instantly!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Job Categories/Sections (e.g., Recommended, Applied, Saved)
            const Text(
              'Job Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip('All Jobs', true),
                  _buildCategoryChip('Recommended', false),
                  _buildCategoryChip('Applied', false),
                  _buildCategoryChip('Saved', false),
                  _buildCategoryChip('Full-time', false),
                  _buildCategoryChip('Part-time', false),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Job Listings (Preview)
            const Text(
              'Recent Job Listings (Preview)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            // These are placeholder job cards. The main Job Hunt list now fetches from Firebase.
            // You might consider removing these if they are no longer needed as a preview.
            _buildJobCard(
              context,
              jobTitle: 'Event Helper Needed',
              company: 'City Events Co.',
              location: 'Colombo',
              salary: 'LKR 5000/day',
              description: 'Seeking energetic individuals for event setup and guest assistance.',
            ),
            _buildJobCard(
              context,
              jobTitle: 'Home Cleaner',
              company: 'Individual Client',
              location: 'Kandy',
              salary: 'LKR 3000/task',
              description: 'Looking for a reliable cleaner for weekly home maintenance.',
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for category chips
  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? Colors.deepPurple[100] : Colors.grey[200],
        labelStyle: TextStyle(
          color: isSelected ? Colors.deepPurple : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.deepPurple : Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
    );
  }

  // Helper widget for a single job card (used for previews or actual lists)
  Widget _buildJobCard(
    BuildContext context, {
    required String jobTitle,
    required String company,
    required String location,
    required String salary,
    required String description,
  }) {
    // This _buildJobCard in JobsMainDashboard is now just for preview.
    // The actual navigation to ViewJobVacancyScreen from here should pass the full Job object
    // if you want to use the updated ViewJobVacancyScreen.
    // For simplicity of this preview, it's still passing individual strings.
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          // Navigate to View Job Vacancy screen
          // Note: This preview card does not have a full Job object.
          // If you want to view full details from these preview cards,
          // you'd need to fetch the job data or pass a dummy Job object.
          // For now, it passes the hardcoded strings.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewJobVacancyScreen(
                jobTitle: jobTitle,
                company: company,
                location: location,
                salary: salary,
                description: description,
                // You would typically pass a Job object here:
                // job: Job(id: '', jobTitle: jobTitle, ...),
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
                    // Navigate to View Job Vacancy screen when "View Details" is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewJobVacancyScreen(
                          jobTitle: jobTitle,
                          company: company,
                          location: location,
                          salary: salary,
                          description: description,
                          // You would typically pass a Job object here:
                          // job: Job(id: '', jobTitle: jobTitle, ...),
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

class JobHuntListScreen {
  const JobHuntListScreen();
}

class EventSquadScreen {
  const EventSquadScreen();
}
