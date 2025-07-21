// lib/screens/helpers_list_screen.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/profile_screen.dart'; // For the main profile icon
import 'package:kuveni_app/screens/helper_profile_screen.dart'; // For navigating to individual helper profiles

class HelpersListScreen extends StatefulWidget {
  const HelpersListScreen({super.key});

  @override
  State<HelpersListScreen> createState() => _HelpersListScreenState();
}

class _HelpersListScreenState extends State<HelpersListScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Placeholder data for various types of helpers
  final List<Map<String, dynamic>> _allHelpers = const [
    {
      'name': 'Dr. Anya Sharma',
      'specialty': 'Counselor (Mental Health)',
      'rating': 4.9,
      'location': 'Online/Colombo',
      'image': 'https://placehold.co/60x60/FFC0CB/000000?text=AS', // Pink
      'bio': 'Experienced mental health counselor specializing in anxiety and stress management. Offers online and in-person sessions.',
      'contact': 'anya.sharma@example.com',
      'price': 'LKR 5,000/session',
    },
    {
      'name': 'Mr. Kamal Perera',
      'specialty': 'Home Maintenance',
      'rating': 4.7,
      'location': 'Kandy',
      'image': 'https://placehold.co/60x60/ADD8E6/000000?text=KP', // Light Blue
      'bio': 'Reliable handyman for all your home repair needs. Specializes in plumbing, electrical, and general fixes.',
      'contact': 'kamal.perera@example.com',
      'price': 'LKR 3,000/hour',
    },
    {
      'name': 'Ms. Sofia Fernando',
      'specialty': 'Yoga Instructor',
      'rating': 4.8,
      'location': 'Galle',
      'image': 'https://placehold.co/60x60/98FB98/000000?text=SF', // Pale Green
      'bio': 'Certified yoga instructor offering personalized sessions for all levels. Focuses on mindfulness and physical well-being.',
      'contact': 'sofia.fernando@example.com',
      'price': 'LKR 2,500/session',
    },
    {
      'name': 'Chef Rohan Silva',
      'specialty': 'Private Chef',
      'rating': 4.9,
      'location': 'Colombo',
      'image': 'https://placehold.co/60x60/FFFACD/000000?text=RS', // Lemon Chiffon
      'bio': 'Award-winning private chef for events and home dining. Specializes in gourmet Sri Lankan and international cuisine.',
      'contact': 'rohan.silva@example.com',
      'price': 'LKR 10,000/meal',
    },
    {
      'name': 'Ms. Dilani Weerasinghe',
      'specialty': 'Elderly Care',
      'rating': 4.6,
      'location': 'Negombo',
      'image': 'https://placehold.co/60x60/D8BFD8/000000?text=DW', // Thistle
      'bio': 'Compassionate and experienced caregiver for elderly individuals. Provides assistance with daily activities and companionship.',
      'contact': 'dilani.w@example.com',
      'price': 'LKR 4,000/day',
    },
  ];

  List<Map<String, dynamic>> _filteredHelpers = [];

  @override
  void initState() {
    super.initState();
    _filteredHelpers = _allHelpers; // Initialize with all helpers
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _filteredHelpers = _allHelpers.where((helper) {
        final nameLower = helper['name']!.toLowerCase();
        final specialtyLower = helper['specialty']!.toLowerCase();
        final locationLower = helper['location']!.toLowerCase();
        final searchQueryLower = query.toLowerCase();

        return nameLower.contains(searchQueryLower) ||
               specialtyLower.contains(searchQueryLower) ||
               locationLower.contains(searchQueryLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0), // Increased height for search bar
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
                      'Find Helpers',
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
                // Search Bar
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search helpers by name, specialty, or location...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    onChanged: _performSearch, // Filter as text changes
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _filteredHelpers.isEmpty && _searchController.text.isNotEmpty
          ? const Center(
              child: Text(
                'No helpers found matching your search.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : _filteredHelpers.isEmpty && _searchController.text.isEmpty
              ? const Center(
                  child: Text(
                    'No helpers available yet. Check back later!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _filteredHelpers.length,
                  itemBuilder: (context, index) {
                    final helper = _filteredHelpers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: InkWell(
                        onTap: () {
                          // Navigate to detailed helper profile screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelperProfileScreen(
                                name: helper['name']!,
                                specialty: helper['specialty']!,
                                rating: helper['rating'].toString(),
                                location: helper['location']!,
                                image: helper['image']!,
                                bio: helper['bio']!,
                                contact: helper['contact']!,
                                price: helper['price']!,
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
                                backgroundImage: NetworkImage(helper['image']!),
                                onBackgroundImageError: (exception, stackTrace) {
                                  print('Error loading helper image: $exception');
                                },
                                child: helper['image'] == null || helper['image']!.isEmpty
                                    ? const Icon(Icons.person, size: 30, color: Colors.white)
                                    : null,
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      helper['name']!,
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      helper['specialty']!,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey[700]),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 16),
                                        Text(
                                          ' ${helper['rating']} • ${helper['location']!}',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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

