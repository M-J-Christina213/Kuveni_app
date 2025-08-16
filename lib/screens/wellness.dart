// lib/screens/wellness.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kuveni_app/screens/profile_screen.dart';

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({super.key});

  @override
  _WellnessScreenState createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _wellnessTips = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWellnessTips();
  }

  Future<void> _fetchWellnessTips() async {
    try {
      final response = await _supabase
          .from('wellness_tips')
          .select('*')
          .order('created_at', ascending: false)
          .execute();
      
      if (response.error == null) {
        setState(() {
          _wellnessTips = (response.data as List).cast<Map<String, dynamic>>();
        });
      } else {
        debugPrint('Error fetching wellness tips: ${response.error!.message}');
        // Handle error
      }
    } catch (e) {
      debugPrint('An unexpected error occurred: $e');
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness'),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _wellnessTips.isEmpty
              ? const Center(child: Text('No wellness tips available.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _wellnessTips.length,
                  itemBuilder: (context, index) {
                    final tip = _wellnessTips[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tip['title'] ?? 'No Title',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              tip['content'] ?? 'No content provided.',
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            // You can add more widgets here like an image or a link
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}