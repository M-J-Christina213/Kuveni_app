// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Income Analysis")),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Hello, Bhagya",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Placeholder(fallbackHeight: 180), // Chart placeholder
            SizedBox(height: 16),
            _AmountTile("12 Jun 2024", "50,000"),
            _AmountTile("10 Jun 2024", "25,000"),
            _AmountTile("8 Jun 2024", "36,000"),
            _AmountTile("5 Jun 2024", "180,000"),
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
