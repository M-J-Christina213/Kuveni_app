// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'setgoal.dart';
//import 'package:percent_indicator/percent_indicator.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Goals")),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SetGoalPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey Bhagya,",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
         //   _GoalCard("New Car", 2500000, 2000000, 0.5019),
          //  _GoalCard("Student Loan", 2000000, 680000, 0.9663),
          ],
        ),
      ),
    );
  }
/*
  Widget _GoalCard(String title, int total, int saved, double percent) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircularPercentIndicator(
          radius: 50,
          lineWidth: 6,
          percent: percent,
          center: Text("${(percent * 100).toStringAsFixed(2)}%"),
          progressColor: Colors.purple,
        ),
        title: Text(title),
        subtitle: Text("Saved: Rs.$saved\nGoal: Rs.$total"),
        trailing: Icon(Icons.analytics),
      ),
    );

    
    
  }
  */
}

