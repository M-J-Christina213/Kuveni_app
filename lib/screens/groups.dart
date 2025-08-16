import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _groups = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  Future<void> _fetchGroups() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _supabase
          .from('groups')
          .select()
          .order('name', ascending: true);

      _groups = (data as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
    } catch (e) {
      debugPrint('An unexpected error occurred: $e');
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
        title: const Text('Community Groups'),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _groups.isEmpty
              ? const Center(child: Text('No groups available.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    itemCount: _groups.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final group = _groups[index];
                      return GroupCard(
                        name: group['name'] ?? 'Unknown Group',
                        description: group['description'] ?? 'No description provided.',
                        members: group['member_count'] ?? 0,
                        onJoin: () {
                          // Implement join group logic (e.g., adding a user to a join table)
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
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description,
                style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$members Members',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
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