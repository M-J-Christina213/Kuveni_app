// lib/screens/set_goal.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SetGoalScreen extends StatefulWidget {
  final String userId;

  const SetGoalScreen({super.key, required this.userId}); 

  @override
  State<SetGoalScreen> createState() => _SetGoalScreenState();
}

class _SetGoalScreenState extends State<SetGoalScreen> {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _targetAmountController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  bool _isLoading = false;

  Future<void> _saveGoal() async {
    final goal = _goalController.text.trim();
    final targetAmount = double.tryParse(_targetAmountController.text.trim());
    final deadline = _deadlineController.text.trim();

    if (goal.isEmpty || targetAmount == null || deadline.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields correctly")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.from('Goals Table').insert({
        'user_id': widget.userId,
        'goal': goal,
        'target_amount': targetAmount,
        'deadline': deadline,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (response.error != null) {
        throw response.error!;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Goal saved successfully!")),
      );

      _goalController.clear();
      _targetAmountController.clear();
      _deadlineController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving goal: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Goal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _goalController,
              decoration: const InputDecoration(
                labelText: "Goal Name",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _targetAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Target Amount",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _deadlineController,
              decoration: const InputDecoration(
                labelText: "Deadline (YYYY-MM-DD)",
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveGoal,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Save Goal"),
            ),
          ],
        ),
      ),
    );
  }
}
