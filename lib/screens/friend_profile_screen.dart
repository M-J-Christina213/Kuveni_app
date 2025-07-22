// lib/screens/friend_profile_screen.dart
// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/profile_screen.dart'; 
import 'package:kuveni_app/screens/image_view_screen.dart'; // For full-screen image view

class FriendProfileScreen extends StatelessWidget {
  final String name;
  final String status;
  final String image;
  final String lastSeen;
  final String bio;

  const FriendProfileScreen({
    super.key,
    required this.name,
    required this.status,
    required this.image,
    required this.lastSeen,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF5902B1),
                Color(0xFF700DB2),
                Color(0xFFF54DB8),
                Color(0xFFEBB41F),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              name, // Friend's name in the AppBar
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
          children: [
            GestureDetector( // Make image clickable for full view
              onTap: () {
                if (image.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewerScreen(
                        imageUrl: image,
                        title: name, // Use friend's name as image viewer title
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No image available to view.')),
                  );
                }
              },
              child: Hero( // For smooth transition
                tag: image, // Unique tag for Hero animation
                child: CircleAvatar(
                  radius: 80, // Larger avatar
                  backgroundImage: image.isNotEmpty ? NetworkImage(image) : null,
                  onBackgroundImageError: (exception, stackTrace) {
                    'Error loading friend profile image: $exception'; // Corrected print
                  },
                  child: image.isEmpty
                      ? const Icon(Icons.person, size: 80, color: Colors.white)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  size: 12,
                  color: status == 'Online'
                      ? Colors.green
                      : (status == 'Away' ? Colors.orange : Colors.grey),
                ),
                const SizedBox(width: 8),
                Text(
                  status,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(width: 16),
                Text(
                  lastSeen,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    'Message $name'; // Corrected print
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Messaging ${name} (Coming Soon!)')),
                    );
                   
                  },
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('Message'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    'Remove $name'; // Corrected print
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Removing ${name} (Coming Soon!)')),
                    );
                    
                  },
                  icon: const Icon(Icons.person_remove),
                  label: const Text('Remove Friend'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red[400],
                    side: BorderSide(color: Colors.red[400]!),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Align(
             
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bio:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bio,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}