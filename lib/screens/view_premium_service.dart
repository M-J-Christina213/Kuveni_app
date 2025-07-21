// lib/screens/view_premium_service.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/checkout.dart';
import 'package:kuveni_app/screens/profile_screen.dart';
import 'package:kuveni_app/screens/image_viewer_screen.dart'; // IMPORTANT: Import ImageViewerScreen

class ViewPremiumServiceScreen extends StatelessWidget {
  final String serviceName;
  final String description;
  final String providerName;
  final String price;
  final String rating;
  final String contactInfo;
  final String fullDetails;
  final String location;
  final String image; // Ensure 'image' is passed to the constructor

  const ViewPremiumServiceScreen({
    super.key,
    required this.serviceName,
    required this.description,
    required this.providerName,
    required this.price,
    required this.rating,
    required this.contactInfo,
    required this.fullDetails,
    required this.location, // Added to constructor
    required this.image, // Added to constructor
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
              serviceName,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector( // Added GestureDetector for image click
                onTap: () {
                  if (image.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageViewerScreen(
                          imageUrl: image,
                          title: providerName, // Use provider's name as image viewer title
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No image available to view.')),
                    );
                  }
                },
                child: Hero( // Added Hero for smooth transition
                  tag: image, // Use image URL as unique tag
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: image.isNotEmpty ? NetworkImage(image) : null,
                    onBackgroundImageError: (exception, stackTrace) {
                      print('Error loading image for $providerName: $exception');
                    },
                    child: image.isEmpty
                        ? const Icon(Icons.person, size: 60, color: Colors.white)
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                providerName,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                serviceName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[700]),
              ),
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
            Center(
              child: Text(
                'Price: $price',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.green),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'About This Service:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              fullDetails,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              contactInfo,
              style: const TextStyle(fontSize: 16, color: Colors.blue, decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEBB41F),
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
                child: const Text('Buy Premium'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
