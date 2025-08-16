// lib/screens/friendlist_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kuveni_app/screens/friend_profile_screen.dart';

class FriendlistScreen extends StatefulWidget {
  const FriendlistScreen({super.key});

  @override
  _FriendlistScreenState createState() => _FriendlistScreenState();
}

class _FriendlistScreenState extends State<FriendlistScreen> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _friends = [];
  bool _isLoading = true;
  final String _currentUserId = Supabase.instance.client.auth.currentUser!.id;

  @override
  void initState() {
    super.initState();
    _fetchFriends();
  }

  Future<void> _fetchFriends() async {
    try {
      final response = await _supabase
          .from('friends')
          .select('friend_id, profiles!friend_id(id, name, username, image_url)')
          .eq('user_id', _currentUserId)
          .execute();
      
      if (response.error == null) {
        setState(() {
          // The data is nested, so we need to extract the profile information
          _friends = (response.data as List)
              .map((e) => e['profiles'] as Map<String, dynamic>)
              .toList();
        });
      } else {
        debugPrint('Error fetching friends: ${response.error!.message}');
      }
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
        title: const Text('My Friends'),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _friends.isEmpty
              ? const Center(child: Text('You have no friends yet.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _friends.length,
                  itemBuilder: (context, index) {
                    final friend = _friends[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: InkWell(
                        onTap: () {
                          // Navigate to friend's profile screen and pass their data
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FriendProfileScreen(
                                name: friend['name'] ?? '',
                                username: friend['username'] ?? '',
                                imageUrl: friend['image_url'] ?? '',
                                status: friend['status'] ?? '',
                                bio: friend['bio'] ?? '',
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(friend['image_url'] ?? ''),
                                onBackgroundImageError: (exception, stackTrace) {
                                  debugPrint('Error loading friend image: $exception');
                                },
                                child: friend['image_url'] == null || friend['image_url'].isEmpty
                                    ? const Icon(Icons.person, size: 30, color: Colors.white)
                                    : null,
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      friend['name'] ?? 'Unknown',
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '@${friend['username'] ?? 'unknown'}',
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}