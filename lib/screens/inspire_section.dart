import 'package:flutter/material.dart';

class InspireStoriesSection extends StatefulWidget {
  const InspireStoriesSection({super.key});

  @override
  State<InspireStoriesSection> createState() => _InspireStoriesSectionState();
}

class _InspireStoriesSectionState extends State<InspireStoriesSection> {
  // List to hold multiple stories
  List<String> stories = [
    '“I quit my toxic job last month after 3 years of stress. Now I freelance as a content writer and feel free. The journey wasn’t easy, but worth every step.”',
  ];

  void _showAddStoryDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Your Story'),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Write your inspiring story here...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newStory = controller.text.trim();
              if (newStory.isNotEmpty) {
                setState(() {
                  stories.insert(0, newStory); // add newest story at top
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Inspire Personal Stories",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple[700],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Display all stories in a list
        for (var story in stories)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade50, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withAlpha(50),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.format_quote, color: Colors.deepPurple, size: 30),
                const SizedBox(height: 8),
                Text(
                  story,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Icon(Icons.favorite, color: Colors.pinkAccent),
                    SizedBox(width: 6),
                    Text('24 likes · 5 comments',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: _showAddStoryDialog,
            icon: const Icon(Icons.add),
            label: const Text("New Story"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
