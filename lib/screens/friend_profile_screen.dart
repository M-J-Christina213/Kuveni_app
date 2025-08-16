// lib/screens/friend_profile_screen.dart
import 'package:flutter/material.dart';

class FriendProfileScreen extends StatelessWidget {
  final String name;
  final String username;
  final String imageUrl;
  final String status;
  final String bio;

  const FriendProfileScreen({
    super.key,
    required this.name,
    required this.username,
    required this.imageUrl,
    required this.status,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.purple[300],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(imageUrl),
              child: imageUrl.isEmpty ? const Icon(Icons.person, size: 60) : null,
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '@$username',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            Text(
              status,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                bio,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}