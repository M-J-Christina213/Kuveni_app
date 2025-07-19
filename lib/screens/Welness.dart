import 'package:flutter/material.dart';

class WellnessScreen extends StatelessWidget {
  const WellnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: const Center(
        child: Text(
          'Wellness content goes here!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}