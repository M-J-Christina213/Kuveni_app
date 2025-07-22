// lib/screens/friends_list_screen.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/profile_screen.dart';
import 'package:kuveni_app/screens/friend_profile_screen.dart';
import 'package:kuveni_app/screens/add_friend_screen.dart';
import 'package:kuveni_app/models/user.dart'; // IMPORTANT: Import the User model

class FriendsListScreen extends StatefulWidget {
  const FriendsListScreen({super.key});

  @override
  State<FriendsListScreen> createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Placeholder data for friends, now using the User model
  final List<User> _friends = [
    User(
      id: 'user1',
      name: 'Aisha Khan',
      status: 'Online',
      image: 'https://placehold.co/60x60/ADD8E6/000000?text=AK',
      lastSeen: 'Active now',
      bio: 'Loves hiking and photography. Always up for an adventure!',
      username: 'aishak',
    ),
    User(
      id: 'user2',
      name: 'Ben Carter',
      status: 'Offline',
      image: 'https://placehold.co/60x60/FFB6C1/000000?text=BC',
      lastSeen: 'Last seen 2 hours ago',
      bio: 'Software engineer passionate about open source and gaming.',
      username: 'benc',
    ),
    User(
      id: 'user3',
      name: 'Chloe Davis',
      status: 'Online',
      image: 'https://placehold.co/60x60/90EE90/000000?text=CD',
      lastSeen: 'Active now',
      bio: 'Yoga instructor and healthy eating advocate. Spreading good vibes!',
      username: 'chloed',
    ),
    User(
      id: 'user4',
      name: 'David Lee',
      status: 'Away',
      image: 'https://placehold.co/60x60/FFDAB9/000000?text=DL',
      lastSeen: 'Away for a trip',
      bio: 'Travel enthusiast and foodie. Exploring new cultures and cuisines.',
      username: 'davidl',
    ),
    User(
      id: 'user5',
      name: 'Eva Martinez',
      status: 'Online',
      image: 'https://placehold.co/60x60/DDA0DD/000000?text=EM',
      lastSeen: 'Active now',
      bio: 'Artist and illustrator. Loves painting landscapes and portraits.',
      username: 'evam',
    ),
  ];

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
                    const Text(
                      'My Friends',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.person_add, color: Colors.white, size: 30),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AddFriendScreen()),
                            );
                          },
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
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search friends...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    onSubmitted: (query) {
                      ('Search friends query: $query');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _friends.isEmpty
          ? const Center(
              child: Text(
                'No friends added yet. Add some friends!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FriendProfileScreen(
                            name: friend.name,
                            status: friend.status,
                            image: friend.image,
                            lastSeen: friend.lastSeen,
                            bio: friend.bio,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(friend.image),
                            onBackgroundImageError: (exception, stackTrace) {
                              ('Error loading friend image: $exception');
                            },
                            child: friend.image.isEmpty
                                ? const Icon(Icons.person, size: 30, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  friend.name,
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: friend.status == 'Online'
                                          ? Colors.green
                                          : (friend.status == 'Away' ? Colors.orange : Colors.grey),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      friend.status,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chat_bubble_outline, color: Colors.blue),
                            onPressed: () {
                          ('Chat with ${friend.name}');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Chat with ${friend.name} (Coming Soon!)')),
                              );
                            },
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
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