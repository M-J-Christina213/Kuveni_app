// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions'),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
      ),
      body: const Center(
        child: Text(
          'Session details will be displayed here.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
