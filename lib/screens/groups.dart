// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> groups = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGroups();
  }

  Future<void> fetchGroups() async {
    try {
      final response = await _supabase.from('community_groups').select();
      setState(() {
        groups = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      ("Error fetching groups: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load groups')),
      );
    }
  }

  Future<void> joinGroup(int groupId, String groupName) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to join a group')),
      );
      return;
    }

    try {
      // 1. Add record to group_memberships
      await _supabase.from('group_memberships').insert({
        'user_id': user.id,
        'group_id': groupId,
      });

      // 2. (Optional) increment members in community_groups table
      await _supabase.rpc('increment_group_members', params: {'gid': groupId});

      // 3. Refresh group list
      await fetchGroups();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You joined "$groupName"!')),
      );
    } catch (e) {
      ("Join error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not join the group')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                    onJoin: () =>
                        joinGroup(group['id'] as int, group['name'] as String),
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