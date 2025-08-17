// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  GroupsScreenState createState() => GroupsScreenState();
}

class GroupsScreenState extends State<GroupsScreen> {
  final _supabase = Supabase.instance.client;
  List<dynamic> _groups = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    try {
      final response = await _supabase.from('groups').select();
      setState(() {
        _groups = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading groups: $e')),
      );
    }
  }

  Future<void> _joinGroup(dynamic groupId) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to join a group')),
      );
      return;
    }

    try {
      await _supabase.from('group_members').insert({
        'group_id': groupId,
        'user_id': userId,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'You have joined the group!',
            style: TextStyle(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.deepPurple,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error joining group: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Groups'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.deepPurple))
          : _groups.isEmpty
              ? const Center(child: Text("No groups available."))
              : ListView.builder(
                  itemCount: _groups.length,
                  itemBuilder: (context, index) {
                    final group = _groups[index];

                    return Card(
                      elevation: 5,
                      color: Colors.deepPurple[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          title: Text(
                            group['name'] ?? 'Unnamed Group',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.deepPurple,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  group['description'] ?? 'No description available.',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Members: ${group['members']}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () => _joinGroup(group['id']),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Join'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}