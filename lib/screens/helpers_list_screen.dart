import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kuveni_app/screens/profile_screen.dart';
import 'package:kuveni_app/screens/helper_profile_screen.dart';

class HelpersListScreen extends StatefulWidget {
  const HelpersListScreen({super.key});

  @override
  State<HelpersListScreen> createState() => _HelpersListScreenState();
}

class _HelpersListScreenState extends State<HelpersListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _allHelpers = [];
  List<Map<String, dynamic>> _filteredHelpers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHelpers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchHelpers() async {
    try {
      final response = await _supabase
          .from('helpers')
          .select('*')
          .order('rating', ascending: false);

      // The response is of type PostgrestList, which is non-nullable.
      // A null check is not needed. The list might be empty, but not null.
      setState(() {
        _allHelpers = (response as List).cast<Map<String, dynamic>>();
        _filteredHelpers = _allHelpers;
      });
    } catch (e) {
      debugPrint('An unexpected error occurred: $e');
      // You can add a Snackbar or other UI feedback here.
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredHelpers = _allHelpers;
      });
      return;
    }

    final searchQueryLower = query.toLowerCase();
    setState(() {
      _filteredHelpers = _allHelpers.where((helper) {
        final nameLower = (helper['name'] as String).toLowerCase();
        final specialtyLower = (helper['specialty'] as String).toLowerCase();
        final locationLower = (helper['location'] as String).toLowerCase();

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
                      hintText: 'Search helpers by name, specialty, or location...',
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
          : _filteredHelpers.isEmpty && _searchController.text.isNotEmpty
              ? const Center(child: Text('No helpers found matching your search.'))
              : _filteredHelpers.isEmpty && _searchController.text.isEmpty
                  ? const Center(child: Text('No helpers available yet.'))
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HelperProfileScreen(
                                    name: helper['name'] ?? '',
                                    specialty: helper['specialty'] ?? '',
                                    rating: (helper['rating'] ?? 0.0).toString(),
                                    location: helper['location'] ?? '',
                                    image: helper['image'] ?? '',
                                    bio: helper['bio'] ?? '',
                                    contact: helper['contact'] ?? '',
                                    price: helper['price'] ?? '',
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
                                    backgroundImage: NetworkImage(helper['image'] ?? ''),
                                    onBackgroundImageError: (exception, stackTrace) {
                                      debugPrint('Error loading helper image: $exception');
                                    },
                                    child: helper['image'] == null || (helper['image'] as String).isEmpty
                                        ? const Icon(Icons.person, size: 30, color: Colors.white)
                                        : null,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          helper['name'] ?? 'Unknown Helper',
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          helper['specialty'] ?? 'N/A',
                                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.amber, size: 16),
                                            Text(
                                              ' ${helper['rating'] ?? 0.0} • ${helper['location'] ?? 'N/A'}',
                                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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