// lib/screens/premium_servicelist.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/view_premium_service.dart'; // Ensure this import is correct

class PremiumServiceListScreen extends StatelessWidget { // Renamed class for consistency
  const PremiumServiceListScreen({super.key});

  final List<Map<String, dynamic>> sampleProviders = const [
    {
      'name': 'Tharushi Jayasena',
      'service': 'Nanny (Upper Class)',
      'rating': 4.9,
      'location': 'Colombo 07',
      'image': 'https://i.imgur.com/N8DqKfT.png', // Ensure these image URLs are valid or use local assets
      'price': 'LKR 75,000/month', // Added price for consistency with ViewPremiumServiceScreen
      'contact': 'tharushi@example.com', // Added contact for consistency
      'fullDetails': 'Experienced and certified nanny providing premium care for children in Colombo 07. Specializes in early childhood development and personalized attention.', // Added fullDetails
    },
    {
      'name': 'Nisansala De Silva',
      'service': 'Professional Cook',
      'rating': 4.8,
      'location': 'Kandy',
      'image': 'https://i.imgur.com/fHyEMsl.png',
      'price': 'LKR 5,000/meal',
      'contact': 'nisansala@example.com',
      'fullDetails': 'Expert chef offering personalized meal preparation for families and events. Specializes in Sri Lankan and international cuisine. Uses fresh, local ingredients.',
    },
    {
      'name': 'Menaka Fernando',
      'service': 'Embroidery Artist',
      'rating': 4.7,
      'location': 'Galle',
      'image': 'https://i.imgur.com/qkdpN.jpg',
      'price': 'Custom Quote',
      'contact': 'menaka@example.com',
      'fullDetails': 'Award-winning embroidery artist creating bespoke designs for clothing, home decor, and gifts. Specializes in traditional and contemporary styles. Consultations available.',
    },
    {
      'name': 'Priya Sharma',
      'service': 'Yoga Instructor',
      'rating': 4.9,
      'location': 'Online/Colombo',
      'image': 'https://placehold.co/60x60/FFD700/000000?text=PS', // Placeholder if no image
      'price': 'LKR 3,000/session',
      'contact': 'priya@example.com',
      'fullDetails': 'Certified yoga instructor offering private and group sessions. Focus on mindfulness, flexibility, and strength. Suitable for all levels.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // Standard AppBar height
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF5902B1), // Deep Purple
                Color(0xFF700DB2), // Lighter Purple
                Color(0xFFF54DB8), // Pink
                Color(0xFFEBB41F), // Orange/Yellow
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Make AppBar background transparent
            elevation: 0, // Remove shadow
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context); // Navigate back
              },
            ),
            title: const Text(
              'Premium Service Providers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true, // Center the title
            actions: [
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 30),
                onPressed: () {
                  // TODO: Navigate to profile screen
                  print('Profile icon tapped from Premium Services List');
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sampleProviders.length,
        itemBuilder: (context, index) {
          final provider = sampleProviders[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(provider['image']!),
                onBackgroundImageError: (exception, stackTrace) {
                  // Fallback to a placeholder icon if image fails to load
                  print('Error loading image: $exception');
                },
                child: provider['image'] == null || provider['image']!.isEmpty
                    ? const Icon(Icons.person, size: 30, color: Colors.white) // Placeholder icon
                    : null,
              ),
              title: Text(provider['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(provider['service']!),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(" ${provider['rating']}  •  ${provider['location']!}"),
                    ],
                  ),
                  Text(provider['price']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to ViewPremiumServiceScreen, passing all provider details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewPremiumServiceScreen(
                      serviceName: provider['service']!,
                      description: provider['description']!, // Using 'description' for fullDetails
                      providerName: provider['name']!,
                      price: provider['price']!,
                      rating: provider['rating'].toString(), // Convert double to String
                      contactInfo: provider['contact']!,
                      fullDetails: provider['fullDetails']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
