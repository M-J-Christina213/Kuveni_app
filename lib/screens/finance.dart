// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'goals.dart';
import 'income.dart';
import 'expenses.dart';
//import './bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, this.username = "Bhagya"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     // bottomNavigationBar: BottomNavBar(currentIndex: 3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(radius: 50, backgroundColor: Colors.amber),
              SizedBox(height: 8),
              Text(
                username,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Premium Member", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _HomeButton("Goals", Icons.track_changes, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => GoalsPage()),
                    );
                  }),
                  _HomeButton("Expenses", Icons.money_off, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ExpensePage()),
                    );
                  }),
                  _HomeButton("Income", Icons.attach_money, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => IncomePage()),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _HomeButton(String title, IconData icon, VoidCallback onTap) {
    return Column(
      children: [
        IconButton(icon: Icon(icon, size: 30), onPressed: onTap),
        Text(title),
      ],
    );
  }
}
