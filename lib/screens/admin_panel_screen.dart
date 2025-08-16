// lib/screens/admin_panel_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;
import 'package:intl/intl.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  // Declare the Supabase client as a late final variable here.
  // This ensures it will be initialized before its first use.
  late final supa.SupabaseClient supabase;

  // Lists to hold requests based on their status
  List<dynamic> _pendingRequests = [];
  List<dynamic> _approvedRequests = [];
  List<dynamic> _deniedRequests = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Initialize the Supabase client within initState.
    // This is the correct way to ensure the client is ready.
    supabase = supa.Supabase.instance.client;
    _fetchAndSortAllRequests();
  }

  // Fetch all requests and sort them into their respective lists.
  Future<void> _fetchAndSortAllRequests() async {
    try {
      final List<dynamic> response = await supabase
          .from('event_squad_requests')
          .select()
          .order('created_at', ascending: false);
      
      // Clear previous lists before sorting
      _pendingRequests.clear();
      _approvedRequests.clear();
      _deniedRequests.clear();

      for (var request in response) {
        if (request['status'] == 'pending') {
          _pendingRequests.add(request);
        } else if (request['status'] == 'approved') {
          _approvedRequests.add(request);
        } else if (request['status'] == 'denied') {
          _deniedRequests.add(request);
        }
      }

      setState(() {
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load requests: $e';
      });
      print('Supabase fetch error: $e');
    }
  }

  // Function to approve a request.
  Future<void> _approveRequest(String requestId) async {
    try {
      await supabase
          .from('event_squad_requests')
          .update({'status': 'approved'})
          .eq('id', requestId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request approved!')),
        );
      }
      _fetchAndSortAllRequests();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to approve request: $e')),
        );
      }
    }
  }

  // New function to deny a request.
  Future<void> _denyRequest(String requestId) async {
    try {
      await supabase
          .from('event_squad_requests')
          .update({'status': 'denied'})
          .eq('id', requestId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request denied!')),
        );
      }
      _fetchAndSortAllRequests();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to deny request: $e')),
        );
      }
    }
  }

  // Function to show a confirmation dialog.
  Future<void> _showConfirmationDialog(String requestId, bool isApprove) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isApprove ? 'Approve Request?' : 'Deny Request?'),
          content: Text(
              'Are you sure you want to ${isApprove ? 'approve' : 'deny'} this request?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: isApprove ? Colors.green : Colors.red,
              ),
              child: Text(isApprove ? 'Approve' : 'Deny'),
              onPressed: () {
                Navigator.of(context).pop();
                if (isApprove) {
                  _approveRequest(requestId);
                } else {
                  _denyRequest(requestId);
                }
              },
            ),
          ],
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Panel'),
          flexibleSpace: Container(
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
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
              Tab(text: 'Denied'),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(child: Text(_errorMessage!))
                : TabBarView(
                    children: [
                      _buildRequestsList(_pendingRequests, isPending: true),
                      _buildRequestsList(_approvedRequests, isPending: false),
                      _buildRequestsList(_deniedRequests, isPending: false),
                    ],
                  ),
      ),
    );
  }

  // Helper method to build the list view for each tab
  Widget _buildRequestsList(List<dynamic> requests, {required bool isPending}) {
    if (requests.isEmpty) {
      return Center(
        child: Text(
          isPending
              ? 'No pending requests to approve.'
              : 'No requests in this category.',
        ),
      );
    }
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(
              request['event_name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text('Location: ${request['location']}'),
                Text('Helpers Required: ${request['helpers_required']}'),
                Text('Posted On: ${_formatDate(request['created_at'])}'),
              ],
            ),
            trailing: isPending
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () => _showConfirmationDialog(request['id'], true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Approve button color
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Approve'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _showConfirmationDialog(request['id'], false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Deny button color
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Deny'),
                      ),
                    ],
                  )
                : null,
          ),
        );
      },
    );
  }
}
