import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kuveni_app/screens/bottom_nav_bar.dart';
import 'package:kuveni_app/screens/logout_screen.dart';
import 'firebase_options.dart';

// Core Screens
import 'package:kuveni_app/screens/home_screen.dart';
import 'package:kuveni_app/screens/login_screen.dart';
import 'package:kuveni_app/screens/register_screen.dart';
import 'package:kuveni_app/screens/safety_screen.dart';
import 'package:kuveni_app/screens/finance_screen.dart';
import 'package:kuveni_app/screens/community_screen.dart';

// Jobs Section Screens
//import 'package:kuveni_app/screens/jobs_main_dashboard.dart';
import 'package:kuveni_app/screens/post_job.dart';
//import 'package:kuveni_app/screens/event_squad.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase

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
        useMaterial3: true,
      ),
      // Set the initial route to your onboarding screen
      // After onboarding, it should navigate to LoginScreen, then to MainScreen.
      initialRoute: '/onboarding',
      routes: {
        // Main application entry point after authentication
        '/': (context) => const MainScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/logout': (context) => const LogoutScreen(),
        '/home': (context) => const HomeScreen(),
        //'/jobs': (context) => const JobsMainDashboard(),
        '/safety': (context) => const SafetyScreen(),
        '/finance': (context) => const FinanceScreen(),
        '/community': (context) => const CommunityScreen(),
        //'/viewJobs': (context) => const JobsMainDashboard(),
        '/postJob': (context) => const PostJobScreen(),
        //'/eventSquadForm': (context) => const EventSquadForm(),
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

  final List<Widget> _screens = [
    HomeScreen(),
    //JobsMainDashboard(),
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
