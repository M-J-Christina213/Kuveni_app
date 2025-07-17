import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/home_screen.dart';
import 'package:kuveni_app/screens/jobs_screen.dart';
import 'package:kuveni_app/screens/safety_screen.dart';
import 'package:kuveni_app/screens/finance_screen.dart';
import 'package:kuveni_app/screens/community_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuveni',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,

      // Initial route
      initialRoute: '/home',

      // Define all routes here
      routes: {
        '/home': (context) => const HomeScreen(),
        '/jobs': (context) => const JobsScreen(),
        '/safety': (context) => const SafetyScreen(),
        '/finance': (context) => const FinanceScreen(),
        '/community': (context) => const CommunityScreen(),
      },
    );
  }
}
