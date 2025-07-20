import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, size: 100, color: Colors.deepPurple),
              const SizedBox(height: 30),
              const Text(
                "You’ve been logged out.",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Thank you for using our app. We hope to see you again soon!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to login or welcome screen
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: const Icon(Icons.login),
                label: const Text("Login Again"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  textStyle:
                      const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
