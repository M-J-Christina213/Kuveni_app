import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bottom_nav_bar.dart';

// Core Screens
import 'package:kuveni_app/screens/home_screen.dart';
import 'package:kuveni_app/screens/safety_screen.dart';
import 'package:kuveni_app/screens/finance_screen.dart';
import 'package:kuveni_app/screens/community_screen.dart';

// Jobs Section Screens
import 'package:kuveni_app/screens/jobs/main_job_dashboard.dart';
import 'package:kuveni_app/screens/jobs/view_jobs_screen.dart';
import 'package:kuveni_app/screens/jobs/premium_Service.dart';
import 'package:kuveni_app/screens/jobs/view_provider.dart';
import 'package:kuveni_app/screens/jobs/post_job.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //  Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuveni',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/viewJobs': (context) => const ViewJobsScreen(),
        '/premiumServices': (context) => const PremiumServicesScreen(),
        '/viewProvider': (context) => const ViewProviderScreen(),
        '/postJob': (context) => const PostJobScreen(), 
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    MainJobDashboard(),
    SafetyScreen(),
    FinanceScreen(),
    CommunityScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
<<<<<<< HEAD



=======
>>>>>>> 1f4e59908d1c946c5b7ce4b825d7cfbb3d736be2
