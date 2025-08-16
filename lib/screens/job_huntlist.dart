// lib/screens/job_huntlist.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/post_job.dart';
// ignore: unused_import
import 'package:supabase_flutter/supabase_flutter.dart' as supa;
import 'package:intl/intl.dart';

// Initialize Supabase client
final supabase = Supabase.instance.client;

class JobHuntListScreen extends StatefulWidget {
  const JobHuntListScreen({super.key});

  @override
  _JobHuntListScreenState createState() => _JobHuntListScreenState();
}

class _JobHuntListScreenState extends State<JobHuntListScreen> {
  // List to store all combined jobs and requests.
  List<dynamic>? _allJobs;
  bool _isLoading = true;
  String? _errorMessage;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch data for both general jobs and approved event squad requests.
    _fetchCombinedJobs();
    // Add a listener to the search controller to trigger filtering on text changes.
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    // This triggers a rebuild of the widget with the new search query.
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

  // Function to fetch and combine data from both tables.
  Future<void> _fetchCombinedJobs() async {
    try {
      // 1. Fetch data from 'general_jobs' table.
      final List<dynamic> generalJobsResponse = await supabase
          .from('general_jobs')
          .select()
          .order('created_at', ascending: false);

      // 2. Fetch data from 'event_squad_requests' table, but filter by status.
      final List<dynamic> eventSquadResponse = await supabase
          .from('event_squad_requests')
          .select()
          .eq('status', 'approved') // Only fetch requests with 'approved' status
          .order('created_at', ascending: false);

      // 3. Combine both lists.
      List<dynamic> combinedList = [...generalJobsResponse, ...eventSquadResponse];

      // 4. Sort the combined list by their creation date.
      combinedList.sort((a, b) {
        final aDate = a['created_at'] != null ? DateTime.parse(a['created_at']) : DateTime.now();
        final bDate = b['created_at'] != null ? DateTime.parse(b['created_at']) : DateTime.now();
        return bDate.compareTo(aDate); // Sort descending (newest first).
      });

      setState(() {
        _allJobs = combinedList;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load jobs: $e';
        _allJobs = null;
      });
      print('Supabase fetch error: $e');
    }
  }

  // Helper function to format the timestamp.
  String _formatDate(String dateString) {
    try {
      final DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('MMM d, yyyy').format(dateTime);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  // A simple filter function to match jobs based on the search query
  List<dynamic> _filterJobs(List<dynamic> jobs) {
    if (_searchQuery.isEmpty) {
      return jobs;
    }
    return jobs.where((job) {
      final isEventSquad = job.containsKey('event_name');
      final title = isEventSquad ? job['event_name']?.toLowerCase() ?? '' : job['job_title']?.toLowerCase() ?? '';
      final location = job['location']?.toLowerCase() ?? '';
      return title.contains(_searchQuery) || location.contains(_searchQuery);
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Job Hunt',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // You can add an IconButton here if needed, for example, for a profile.
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
                      hintText: 'Search for jobs...',
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _allJobs!.isEmpty
                  ? const Center(child: Text('No job requests found.'))
                  : ListView.builder(
                      itemCount: _filterJobs(_allJobs!).length,
                      itemBuilder: (context, index) {
                        final filteredJobs = _filterJobs(_allJobs!);
                        final job = filteredJobs[index];
                        final isEventSquad = job.containsKey('event_name');
                        
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              isEventSquad ? job['event_name'] : job['job_title'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                // Display job type
                                Text(
                                  'Type: ${isEventSquad ? 'Event Squad Request' : 'General Job'}',
                                  style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blueAccent),
                                ),
                                const SizedBox(height: 4),
                                Text('Location: ${job['location']}'),
                                Text('Posted On: ${_formatDate(job['created_at'])}'),
                                // Conditionally display the payment/helpers field
                                if (isEventSquad)
                                  Text('Helpers Required: ${job['helpers_required']}')
                                else
                                  Text('Payment: ${job['payment_details']}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
