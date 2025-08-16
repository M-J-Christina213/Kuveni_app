import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kuveni_app/screens/bottom_nav_bar.dart';
import 'package:kuveni_app/screens/jobs_main_dashboard.dart';
import 'package:kuveni_app/screens/logout_screen.dart';
import 'package:kuveni_app/screens/splash_screen.dart';
import 'package:kuveni_app/screens/walkthrough_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

// Core Screens
import 'package:kuveni_app/screens/home_screen.dart';
import 'package:kuveni_app/screens/login_screen.dart';
import 'package:kuveni_app/screens/register_screen.dart';
import 'package:kuveni_app/screens/safety_screen.dart';
import 'package:kuveni_app/screens/finance_screen.dart';
import 'package:kuveni_app/screens/community_screen.dart';

// Jobs Section Screens
import 'package:kuveni_app/screens/post_job.dart';

void main() async {
  // Ensure that Flutter's widget binding is initialized before
  // any plugins are used, which is required for Supabase.
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from the .env file.
  // This must be done before Supabase.initialize.
  await dotenv.load(fileName: ".env");

  // Supabase initialization with URL and anon key from .env.
  // This is the correct place to initialize the Supabase client.
  await supa.Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

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
      initialRoute: '/splash',
      routes: {
        // Main application entry point after authentication
        '/': (context) => const MainScreen(),
        '/splash': (context) => const SplashScreen(),
        '/walkthrough': (context) => const WalkthroughScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/logout': (context) => const LogoutScreen(),
        '/home': (context) => const HomeScreen(),
        '/jobs': (context) => const JobsMainDashboard(),
        '/safety': (context) => const SafetyScreen(),
        '/finance': (context) => const FinanceScreen(),
        '/community': (context) => const CommunityScreen(),
        '/viewJobs': (context) => const JobsMainDashboard(),
        '/postJob': (context) => const PostJobScreen(),
        // This is the updated route to the Supabase-enabled EventSquadScreen
        '/eventSquadForm': (context) => const JobsMainDashboard(),
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
    const HomeScreen(),
    const JobsMainDashboard(),
    const SafetyScreen(),
    const FinanceScreen(),
    const CommunityScreen(),
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
