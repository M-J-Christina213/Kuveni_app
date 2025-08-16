// lib/screens/premium_service_list_screen.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/submit_premium_service_screen.dart';
import 'package:kuveni_app/screens/view_premium_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

class PremiumServiceListScreen extends StatefulWidget {
  const PremiumServiceListScreen({super.key});

  @override
  State<PremiumServiceListScreen> createState() => _PremiumServiceListScreenState();
}

class _PremiumServiceListScreenState extends State<PremiumServiceListScreen> {
  late final Stream<List<Map<String, dynamic>>> _servicesStream;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Initialize the stream with a base query
    _servicesStream = supa.Supabase.instance.client
        .from('premium_services')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false);

    // Add a listener to the search controller to rebuild the widget on text changes
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    // This triggers a rebuild of the widget with the new search query
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // A simple filter function to match services based on the search query
  List<Map<String, dynamic>> _filterServices(List<Map<String, dynamic>> services) {
    if (_searchQuery.isEmpty) {
      return services;
    }
    return services.where((service) {
      final serviceName = service['service_name']?.toLowerCase() ?? '';
      final providerName = service['provider_name']?.toLowerCase() ?? '';
      final location = service['location']?.toLowerCase() ?? '';
      return serviceName.contains(_searchQuery) ||
          providerName.contains(_searchQuery) ||
          location.contains(_searchQuery);
    }).toList();
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
                      'Premium Services',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person, color: Colors.white, size: 30),
                      onPressed: () {
                        // Navigate to profile screen
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Search bar
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
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
                      hintText: 'Search for services...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _servicesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No premium services found.'));
          }

          // Filter the data based on the search query
          final services = _filterServices(snapshot.data!);

          if (services.isEmpty) {
            return const Center(child: Text('No matching services found.'));
          }

          return ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewPremiumServiceScreen(
                          serviceName: service['service_name'] ?? 'No service name',
                          description: service['qualifications'] ?? 'No qualifications provided.',
                          providerName: service['provider_name'] ?? 'Unknown Provider',
                          price: service['rate'] ?? 'Not specified',
                          rating: service['rating']?.toString() ?? 'N/A', // Pass rating
                          contactInfo: service['contact_info'] ?? 'Not provided',
                          fullDetails: service['description'] ?? 'No description provided.',
                          location: service['location'] ?? 'Not specified',
                          image: service['image_url'] ?? '',
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service['service_name'] ?? 'No service name',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5902B1),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rate: ${service['rate'] ?? 'Not specified'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Description: ${service['description'] ?? 'No description provided.'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubmitPremiumServiceScreen()),
          );
        },
        backgroundColor: const Color(0xFF5902B1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
