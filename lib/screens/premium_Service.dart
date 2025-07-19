import 'package:flutter/material.dart';

class PremiumServicesScreen extends StatelessWidget {
  const PremiumServicesScreen({super.key});

  final List<Map<String, dynamic>> sampleProviders = const [
    {
      'name': 'Tharushi Jayasena',
      'service': 'Nanny (Upper Class)',
      'rating': 4.9,
      'location': 'Colombo 07',
      'image': 'https://i.imgur.com/N8DqKfT.png',
    },
    {
      'name': 'Nisansala De Silva',
      'service': 'Professional Cook',
      'rating': 4.8,
      'location': 'Kandy',
      'image': 'https://i.imgur.com/fHyEMsl.png',
    },
    {
      'name': 'Menaka Fernando',
      'service': 'Embroidery Artist',
      'rating': 4.7,
      'location': 'Galle',
      'image': 'https://i.imgur.com/qkdpN.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Premium Service Providers"),
        backgroundColor: Color(0xFF700DB2),
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
                backgroundImage: NetworkImage(provider['image']),
              ),
              title: Text(provider['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(provider['service']),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(" ${provider['rating']}  •  ${provider['location']}"),
                    ],
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/viewProvider', arguments: provider);
              },
            ),
          );
        },
      ),
    );
  }
}