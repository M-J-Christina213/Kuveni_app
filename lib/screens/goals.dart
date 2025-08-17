// lib/screens/goals.dart
// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/setgoal.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './bottom_nav_bar.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> goals = [];
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  /// Fetch incomes, expenses, and goals
  Future<void> _fetchData() async {
    await _calculateSavings();
    await _fetchGoals();
  }

  /// Fetch total income and expenses dynamically from database
  Future<void> _calculateSavings() async {
    try {
      final incomesResponse = await supabase.from('Income Table').select('id, title, amount, date');
      final expensesResponse = await supabase.from('Expenses Table').select('id, title, amount, date');

      totalIncome = (incomesResponse as List<dynamic>)
          .fold(0, (sum, item) => sum + (item['amount'] as int));
      totalExpense = (expensesResponse as List<dynamic>)
          .fold(0, (sum, item) => sum + (item['amount'] as int));

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to calculate savings: $e")),
      );
    }
  }

  int get availableSavings => totalIncome - totalExpense;

  /// Fetch all goals from Supabase
  Future<void> _fetchGoals() async {
    try {
      final response = await supabase
          .from('Goals Table')
          .select()
          .order('created_at', ascending: false);

      setState(() {
        goals = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch goals: $e")),
      );
    }
  }

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
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/community');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SetGoalScreen()),
          ).then((_) => _fetchData()); // Refresh after adding a goal
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
            ...goals.map((goal) {
              final goalAmount = goal['target_amount'] as double? ?? 0.0;
              double savedAmount;

              // Use available savings to calculate goal progress
              if (availableSavings >= goalAmount) {
                savedAmount = goalAmount;
              } else {
                savedAmount = availableSavings.toDouble();
              }

              final percent =
                  goalAmount == 0 ? 0.0 : (savedAmount / goalAmount).clamp(0.0, 1.0);

              return _GoalCard(
                context,
                goal['title'] ?? "Unnamed Goal",
                goalAmount.toInt(),
                savedAmount.toInt(),
                percent,
                "assets/images/loan.png",
              );
            }),
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
              percent: percent,
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
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Saved: Rs.$saved",
                      style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  Text("Goal: Rs.$total",
                      style: const TextStyle(fontSize: 14, color: Colors.black54)),
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