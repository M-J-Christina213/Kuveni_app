// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Analysis")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Hello, Bhagya",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Placeholder(fallbackHeight: 180),
            SizedBox(height: 16),
            _AmountTile("1 Jan 2024", "20,000"),
            _AmountTile("12 May 2024", "12,000"),
            _AmountTile("16 May 2024", "6,000"),
            _AmountTile("1 Apr 2024", "9,000"),
          ],
        ),
      ),
    );
  }

  Widget _AmountTile(String date, String amount) {
    return ListTile(
      title: Text(date),
      trailing: Text(
        "Rs. $amount",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
