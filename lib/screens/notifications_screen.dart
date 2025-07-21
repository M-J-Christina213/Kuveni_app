import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, String>> notifications = const [
    {
      "title": "Exclusive Offer!",
      "body": "Enjoy 30% off at Serenity Spa Resort this weekend. Pamper yourself!",
    },
    {
      "title": "Safety Tip",
      "body": "Always share your ride details with a trusted contact before your journey.",
    },
    {
      "title": "Wellness Reminder",
      "body": "Take a 5-minute mindfulness break — breathe deeply and relax.",
    },
    {
      "title": "Community Event",
      "body": "Join our Women’s Wellness Workshop online this Friday at 6 PM.",
    },
    {
      "title": "Quote of the Day",
      "body": "“She remembered who she was and the game changed.”",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.purple,
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                "No notifications yet. Stay tuned!",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  leading: const Icon(Icons.notifications_active, color: Colors.purple),
                  title: Text(
                    notification["title"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(notification["body"]!),
                  onTap: () {
                    // Optional: open detailed view or mark as read
                  },
                );
              },
            ),
    );
  }
}
