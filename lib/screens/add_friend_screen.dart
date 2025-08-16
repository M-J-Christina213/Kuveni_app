// lib/screens/add_friend_screen.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/profile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }
    
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _supabase
          .from('profiles')
          .select('*')
          .ilike('username', '%$query%')
          .execute();

      if (response.error == null) {
        setState(() {
          _searchResults = (response.data as List).cast<Map<String, dynamic>>();
        });
      } else {
        ('Error searching users: ${response.error!.message}');
        setState(() {
          _searchResults = [];
        });
      }
    } catch (e) {
      ('An unexpected error occurred: $e');
      setState(() {
        _searchResults = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      'Add Friend',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                const SizedBox(height: 10),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name or username...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    onChanged: _performSearch,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty && _searchController.text.isEmpty
              ? const Center(
                  child: Text(
                    'Start typing to find friends!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : _searchResults.isEmpty && _searchController.text.isNotEmpty
                  ? const Center(
                      child: Text(
                        'No users found.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final user = _searchResults[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(user['image_url'] ?? ''),
                                  onBackgroundImageError: (exception, stackTrace) {
                                    debugPrint('Error loading user image: $exception');
                                  },
                                  child: user['image_url'] == null || user['image_url'].isEmpty
                                      ? const Icon(Icons.person, size: 30, color: Colors.white)
                                      : null,
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user['name'] ?? 'No Name',
                                        style: const TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '@${user['username'] ?? 'unknown'}',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Implement logic to send friend request
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Friend request sent to ${user['name']}!')),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[400],
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text('Add'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}