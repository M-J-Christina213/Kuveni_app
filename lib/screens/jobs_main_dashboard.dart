import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/post_job.dart';
import 'package:kuveni_app/screens/event_squad.dart';
import 'package:kuveni_app/screens/job_huntlist.dart';
import 'package:kuveni_app/screens/premium_servicelist.dart';
import 'package:kuveni_app/screens/checkout.dart';
import 'package:kuveni_app/screens/profile_screen.dart';
import 'package:kuveni_app/screens/dashboard_card.dart'; // Import the new reusable card widget

class JobsMainDashboard extends StatefulWidget {
  const JobsMainDashboard({super.key});

  @override
  State<JobsMainDashboard> createState() => _JobsMainDashboardState();
}

class _JobsMainDashboardState extends State<JobsMainDashboard> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
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
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Job Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                const SizedBox(height: 10),
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
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    onSubmitted: (query) {
                      // This will be implemented when we connect to the backend
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
            // Use the new DashboardCard widget
            DashboardCard(
              title: 'Post a Job',
              subtitle: 'Reach out to thousands of helpers!',
              icon: Icons.add_circle_outline,
              iconColor: Colors.deepPurple[400]!,
              destinationScreen: const PostJobScreen(),
            ),
            DashboardCard(
              title: 'Event Squad Form',
              subtitle: 'Request helpers for your events!',
              icon: Icons.event_note,
              iconColor: Colors.orange[400]!,
              destinationScreen: const EventSquadForm(),
            ),
            DashboardCard(
              title: 'Job Hunt',
              subtitle: 'Explore available job vacancies!',
              icon: Icons.search_rounded,
              iconColor: Colors.blue[400]!,
              destinationScreen: const JobHuntListScreen(),
            ),
            DashboardCard(
              title: 'Premium Services',
              subtitle: 'Discover exclusive helper services!',
              icon: Icons.workspace_premium,
              iconColor: Colors.amber[700]!,
              destinationScreen: const PremiumServiceListScreen(),
            ),
            DashboardCard(
              title: 'Buy Premium Now',
              subtitle: 'Access all premium features instantly!',
              icon: Icons.shopping_cart,
              iconColor: Colors.pink[400]!,
              destinationScreen: const CheckoutScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
