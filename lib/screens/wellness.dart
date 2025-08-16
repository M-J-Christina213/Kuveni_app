import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({super.key});

  @override
  WellnessScreenState createState() => WellnessScreenState();
}

class WellnessScreenState extends State<WellnessScreen> {
  final _supabase = Supabase.instance.client;
  late Future<List<Map<String, dynamic>>> _wellnessTips;

  final List<Color> cardColors = [
    const Color(0xFFE1BEE7), // Light Purple
    const Color(0xFFFFCCBC), // Light Orange
    const Color(0xFFB2EBF2), // Light Cyan
    const Color(0xFFC8E6C9), // Light Green
    const Color(0xFFFFF9C4), // Light Yellow
    const Color(0xFFD1C4E9), // Lavender
  ];

  @override
  void initState() {
    super.initState();
    _wellnessTips = _fetchWellnessTips();
  }

  Future<List<Map<String, dynamic>>> _fetchWellnessTips() async {
    final response = await _supabase
        .from('wellness_tips')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Tips'),
        centerTitle: true,
        flexibleSpace: Container(
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
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _wellnessTips,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No wellness tips available.'));
          }

          final tips = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tips.length,
            itemBuilder: (context, index) {
              final tip = tips[index];
              final color = cardColors[index % cardColors.length]; // Rotate colors
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: color,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip['title'] ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tip['content'] ?? 'No Content',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}