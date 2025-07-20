import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  final List<Map<String, dynamic>> groups = const [
    {
      'name': 'Self-Defense Girls',
      'description': 'Empower yourself with confidence and skills.',
      'members': 42,
    },
    {
      'name': 'Single Moms',
      'description': 'A space for support and strength.',
      'members': 68,
    },
    {
      'name': 'Women in Tech',
      'description': 'Connect, share and grow in tech.',
      'members': 35,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Groups'),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: groups.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final group = groups[index];
            return GroupCard(
              name: group['name'],
              description: group['description'],
              members: group['members'],
              onJoin: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Joined "${group['name']}"')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final String name;
  final String description;
  final int members;
  final VoidCallback onJoin;

  const GroupCard({
    super.key,
    required this.name,
    required this.description,
    required this.members,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description,
                style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$members Members',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
                ElevatedButton(
                  onPressed: onJoin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Join"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
