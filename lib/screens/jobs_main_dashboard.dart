// lib/screens/jobs_main_dashboard.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/event_squad_screen.dart';
import 'package:kuveni_app/screens/post_job.dart';
import 'package:kuveni_app/screens/job_huntlist.dart';
import 'package:kuveni_app/screens/premium_service_list_screen.dart';
import 'package:kuveni_app/screens/checkout.dart';
import 'package:kuveni_app/screens/profile_screen.dart';
import 'package:kuveni_app/screens/dashboard_card.dart';
import 'package:kuveni_app/screens/admin_panel_screen.dart';
import 'package:kuveni_app/screens/submit_premium_service_screen.dart'; // New import for submitting a service
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

class JobsMainDashboard extends StatefulWidget {
  const JobsMainDashboard({super.key});

  @override
  State<JobsMainDashboard> createState() => _JobsMainDashboardState();
}

class _JobsMainDashboardState extends State<JobsMainDashboard> {
  // Declare the supabase client here as a late final variable.
  // This tells Dart that it will be initialized later,
  // before it's first used.
  late final supa.SupabaseClient supabase;
  final TextEditingController _searchController = TextEditingController();

  // A boolean to track if the user is an admin.
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    // Initialize the supabase client instance here, within initState().
    // This ensures it is ready for use when the widget is built.
    supabase = supa.Supabase.instance.client;
    
    // Set up a listener for auth state changes to determine if the user is an admin.
    // This is more reliable than a simple getter that runs on every build.
    supabase.auth.onAuthStateChange.listen((data) {
      final supa.Session? session = data.session;
      if (session != null) {
        // Check if the current user ID matches the admin ID.
        if (session.user.id == 'YOUR_ADMIN_USER_ID') {
          setState(() {
            _isAdmin = true;
          });
        }
      }
    });
  }

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
            // Corrected: Card to view the list of premium services
            DashboardCard(
              title: 'Premium Services',
              subtitle: 'Discover exclusive helper services!',
              icon: Icons.workspace_premium,
              iconColor: Colors.amber[700]!,
              destinationScreen: const PremiumServiceListScreen(),
            ),
            // New card to submit a premium service
            DashboardCard(
              title: 'Submit a Premium Service',
              subtitle: 'Offer your unique skills and get hired!',
              icon: Icons.add_circle_outline,
              iconColor: Colors.amber[700]!,
              destinationScreen: const SubmitPremiumServiceScreen(),
            ),
            DashboardCard(
              title: 'Buy Premium Now',
              subtitle: 'Access all premium features instantly!',
              icon: Icons.shopping_cart,
              iconColor: Colors.pink[400]!,
              destinationScreen: const CheckoutScreen(),
            ),
            // Conditionally show Admin Panel
            if (_isAdmin)
              DashboardCard(
                title: 'Admin Panel',
                subtitle: 'Manage pending event requests.',
                icon: Icons.admin_panel_settings,
                iconColor: Colors.red[400]!,
                destinationScreen: const AdminPanelScreen(),
              ),
          ],
        ),
      ),
    );
  }
}
