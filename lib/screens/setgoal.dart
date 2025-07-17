import 'package:flutter/material.dart';

class SetGoalPage extends StatelessWidget {
  final titleCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final infoCtrl = TextEditingController();

  SetGoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Goals")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, Bhagya", style: TextStyle(fontSize: 18)),
            Text(
              "Set your new goal",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceCtrl,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: infoCtrl,
              decoration: InputDecoration(labelText: 'More Info'),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: Text("SAVE")),
          ],
        ),
      ),
    );
  }
}
