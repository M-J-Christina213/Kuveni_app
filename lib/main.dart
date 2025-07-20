import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Correct: Generated Firebase options

// Import the main screen that manages the bottom navigation bar
import 'package:kuveni_app/main_screen.dart'; // IMPORTANT: This is the correct MainScreen

// Import authentication screens
import 'package:kuveni_app/screens/login_screen.dart';
import 'package:kuveni_app/screens/register_screen.dart';
import 'package:kuveni_app/screens/onboarding_screen.dart'; // Assuming you want to start with onboarding

// Import other sub-screens that might be navigated to directly (e.g., from deep links or specific actions)
// Note: Most screens accessed via BottomNavBar tabs (HomeScreen, JobsMainDashboard, etc.)
// do NOT need top-level named routes if MainScreen handles them.
// Only add routes here if you need to jump directly to them from outside the main tab flow.
import 'package:kuveni_app/screens/post_job.dart';
import 'package:kuveni_app/screens/event_squad.dart'; // Corrected name from EventSquadForm
import 'package:kuveni_app/screens/premium_servicelist.dart'; // Corrected name from Premium_Service
import 'package:kuveni_app/screens/view_premium_service.dart'; // Corrected name from View_Provider
import 'package:kuveni_app/screens/checkout.dart'; // For direct access from JobsMainDashboard

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully!");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

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

        // Authentication flow
        '/onboarding': (context) => const OnboardingScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),

        // Direct navigation to specific forms/lists (if needed outside main tabs)
        // These are typically navigated to using Navigator.push from within a tab.
        // I'm keeping them here only if there's a specific reason to jump to them via named routes.
        // Otherwise, it's cleaner to use MaterialPageRoute for sub-screen navigation.
        '/postJob': (context) => const PostJobScreen(),
        '/eventSquad': (context) => const EventSquadScreen(), // Corrected route name
        '/premiumServiceList': (context) => const PremiumServiceListScreen(), // Corrected route name
        '/viewPremiumService': (context) => const ViewPremiumServiceScreen(
              // This route requires arguments. It's better to push with MaterialPageRoute.
              // If you insist on a named route, you'd need to extract arguments here.
              // For now, providing dummy values to make it compile, but direct push is better.
              serviceName: 'Default Service',
              description: 'Default Description',
              providerName: 'Default Provider',
              price: 'N/A',
              rating: 'N/A',
              contactInfo: 'N/A',
              fullDetails: 'Default Full Details',
            ),
        '/checkout': (context) => const CheckoutScreen(), // For direct navigation from JobsMainDashboard
      },
      // IMPORTANT: Removed the duplicate MainScreen class definition from here.
      // It should only be in lib/main_screen.dart.
    );
  }
}
