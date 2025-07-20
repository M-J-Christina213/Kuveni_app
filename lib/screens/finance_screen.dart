// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'goals.dart';
import 'income.dart';
import 'expenses.dart';
import './bottom_nav_bar.dart';

class FinanceScreen extends StatelessWidget {
  final String username;

  const FinanceScreen({super.key, this.username = "Bhagya"});

  static const Color lavenderPurple = Color(0xFFD6C9F8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 1) return;
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/jobs');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/safety');
              break;

            case 3:
              Navigator.pushReplacementNamed(context, '/community');
              break;
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profilepic.png'),
              ),
              const SizedBox(height: 12),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 28,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const Text(
                "Premium Member",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 36),

              // Row 1 - Goals button full width
              _ColorfulButton(
                title: "Goals",
                imagePath: 'assets/images/goal.webp',
                color: lavenderPurple,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GoalsPage()),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Row 2 - Expenses & Income
              Row(
                children: [
                  Expanded(
                    child: _ColorfulButton(
                      title: "Expenses",
                      imagePath: 'assets/images/expenses.jpg',
                      color: lavenderPurple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ExpensePage()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _ColorfulButton(
                      title: "Income",
                      imagePath: 'assets/images/income.png',
                      color: lavenderPurple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => IncomePage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ColorfulButton({
    required String title,
    required String imagePath,
    required Color color,
    required VoidCallback onTap,
    double? width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity, // full width if width not given
        height: 120, // slightly smaller height for phones
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: color, blurRadius: 10, offset: const Offset(0, 6)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
              ), // space from right edge
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
