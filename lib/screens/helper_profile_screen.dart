// lib/screens/helper_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/profile_screen.dart'; // For the main profile icon
import 'package:kuveni_app/screens/image_viewer_screen.dart'; // For full-screen image view

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
              name, // Helper's name in the AppBar
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (image.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewerScreen(
                        imageUrl: image,
                        title: name,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No image available to view.')),
                  );
                }
              },
              child: Hero(
                tag: image,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: image.isNotEmpty ? NetworkImage(image) : null,
                  onBackgroundImageError: (exception, stackTrace) {
                    print('Error loading helper profile image: $exception');
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
            Text(
              specialty,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[700]),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '$rating out of 5',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, color: Colors.blueGrey, size: 20),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Price: $price',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.green),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: CrossAxisAlignment.start,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Me:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bio,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Contact:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    contact,
                    style: const TextStyle(fontSize: 16, color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                print('Request Service from $name');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Requesting service from ${name} (Coming Soon!)')),
                );
                // TODO: Implement service request logic (e.g., navigate to a booking form)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEBB41F), // Orange/Yellow
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Request Service'),
            ),
          ],
        ),
      ),
    );
  }
}
