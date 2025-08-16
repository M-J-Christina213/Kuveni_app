// lib/screens/helper_profile_screen.dart
import 'package:flutter/material.dart';

class HelperProfileScreen extends StatelessWidget {
  final String name;
  final String specialty;
  final String rating;
  final String location;
  final String image;
  final String bio;
  final String contact;
  final String price;

  const HelperProfileScreen({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.location,
    required this.image,
    required this.bio,
    required this.contact,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.purple[300],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(image),
                child: image.isEmpty ? const Icon(Icons.person, size: 60) : null,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                specialty,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    rating,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'About',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              bio,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: $price',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Location: $location',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Contact: $contact',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}