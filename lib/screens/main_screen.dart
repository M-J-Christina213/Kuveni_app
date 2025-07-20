// lib/main_screen.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/bottom_nav_bar.dart'; // Import your custom BottomNavBar

// Import all the main content screens that will be displayed by the BottomNavBar.
// Make sure these files exist in your 'lib/screens/' directory.
import 'package:kuveni_app/screens/home_screen.dart';
import 'package:kuveni_app/screens/jobs_main_dashboard.dart'; // This is your 'Jobs' tab content
import 'package:kuveni_app/screens/safety_screen.dart';
import 'package:kuveni_app/screens/finance_screen.dart';
import 'package:kuveni_app/screens/community_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // State variable to keep track of the selected tab index

  // List of the main content widgets corresponding to each tab in the BottomNavBar.
  // The order here MUST match the order of items in your BottomNavBar (Home, Jobs, Safety, Finance, Community).
  final List<Widget> _screens = [
    const HomeScreen(),        // Index 0: Home tab
    const JobsMainDashboard(),  // Index 1: Jobs tab
    const SafetyScreen(),       // Index 2: Safety tab
    const FinanceScreen(),      // Index 3: Finance tab
    const CommunityScreen(),    // Index 4: Community tab
  ];

  // Callback function for when a BottomNavBar item is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the current index, which triggers a UI rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body of the Scaffold uses IndexedStack to display the selected page.
      // IndexedStack keeps all children alive but only shows the one at 'index'.
      // This is efficient for tab navigation as it preserves the state of other tabs.
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      // Your custom BottomNavBar is placed at the bottom.
      // We pass the current index and the onTap callback to it.
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}