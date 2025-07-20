// lib/screens/view_premium_service.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/checkout.dart'; // IMPORTANT: Import the CheckoutScreen

class ViewPremiumServiceScreen extends StatelessWidget {
  final String serviceName;
  final String description;
  final String providerName;
  final String price;
  final String rating;
  final String contactInfo;
  final String fullDetails;

  const ViewPremiumServiceScreen({
    super.key,
    required this.serviceName,
    required this.description,
    required this.providerName,
    required this.price,
    required this.rating,
    required this.contactInfo,
    required this.fullDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar with gradient background
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
                Navigator.pop(context); // Navigate back to PremiumServiceListScreen
              },
            ),
            title: Text(
              serviceName, // Display the service name in the app bar
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
                 
                'Profile icon tapped from View Premium Service';
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
            Text(
              serviceName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 8),
            Text(
              'Provided by: $providerName',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '$rating out of 5',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Price: $price',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green),
            ),
            const SizedBox(height: 16),
            const Text(
              'Service Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              fullDetails,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              contactInfo,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the CheckoutScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEBB41F), // Using an orange/yellow from your gradient
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
