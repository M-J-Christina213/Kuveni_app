import 'package:flutter/material.dart';

class ViewProviderScreen extends StatelessWidget {
  const ViewProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(provider['name']),
        backgroundColor: const Color(0xFF700DB2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(provider['image']),
            ),
            const SizedBox(height: 20),
            Text(
              provider['service'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text(" ${provider['rating']}  •  ${provider['location']}"),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Request Sent!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF700DB2),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text("Request Service", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}