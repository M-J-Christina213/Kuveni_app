// lib/screens/goals.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/setgoal.dart'; // Import the SetGoalPage
// import 'package:percent_indicator/percent_indicator.dart'; // Keep if you uncomment _GoalCard later

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Goals"),
        // You might want to match the gradient app bar style here for consistency
        // For example:
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Color(0xFF5902B1), Color(0xFF700DB2), Color(0xFFF54DB8), Color(0xFFEBB41F),
        //       ],
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //     ),
        //   ),
        // ),
        // backgroundColor: Colors.transparent, // Make sure this is set if using flexibleSpace
        // elevation: 0,
      ),
      // IMPORTANT: Removed the BottomNavigationBar from here.
      // The main BottomNavBar is controlled by MainScreen.

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SetGoalPage()), // Ensure SetGoalPage is const
          );
        },
        child: const Icon(Icons.add), // Made const
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text( // Made const
              "Hey Bhagya,",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24), // Made const
            // Uncomment and use _GoalCard when you have actual data and percent_indicator set up
            /*
            _GoalCard("New Car", 2500000, 2000000, 0.5019),
            _GoalCard("Student Loan", 2000000, 680000, 0.9663),
            */
          ],
        ),
      ),
    );
  }

  // Keep this helper method if you plan to use it later
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


