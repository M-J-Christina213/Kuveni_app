// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'setgoal.dart';
import './bottom_nav_bar.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Goals")),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/jobs');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/safety');
          } else if (index == 3) {
            // Already in Finance
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/community');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SetGoalPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Hey Bhagya,",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _GoalCard(
              context,
              "New Car",
              2500000,
              2000000,
              0.50,
              "assets/images/car.png",
            ),
            _GoalCard(
              context,
              "Student Loan",
              2000000,
              680000,
              0.96,
              "assets/images/loan.png",
            ),
          ],
        ),
      ),
    );
  }

  Widget _GoalCard(
    BuildContext context,
    String title,
    int total,
    int saved,
    double percent,
    String imagePath,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            CircularPercentIndicator(
              radius: 35,
              lineWidth: 6,
              percent: percent.clamp(0.0, 1.0),
              center: Text("${(percent * 100).toStringAsFixed(0)}%"),
              progressColor: Colors.purple,
              backgroundColor: Colors.grey.shade300,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Saved: Rs.$saved",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Text(
                    "Goal: Rs.$total",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Image.asset(imagePath, width: 40, height: 40, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
