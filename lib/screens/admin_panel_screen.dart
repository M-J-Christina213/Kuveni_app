// lib/screens/admin_panel_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

// Initialize Supabase client
final supabase = Supabase.instance.client;

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  List<dynamic>? _pendingRequests;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchPendingRequests();
  }

  // Fetch only pending requests from the database.
  Future<void> _fetchPendingRequests() async {
    try {
      final List<dynamic> response = await supabase
          .from('event_squad_requests')
          .select()
          .eq('status', 'pending')
          .order('created_at', ascending: false);
      
      setState(() {
        _pendingRequests = response;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load pending requests: $e';
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request approved!')),
      );

      // Refresh the list to remove the approved request.
      _fetchPendingRequests();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to approve request: $e')),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _pendingRequests!.isEmpty
                  ? const Center(child: Text('No pending requests to approve.'))
                  : ListView.builder(
                      itemCount: _pendingRequests!.length,
                      itemBuilder: (context, index) {
                        final request = _pendingRequests![index];
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
                            trailing: ElevatedButton(
                              onPressed: () => _approveRequest(request['id']),
                              child: const Text('Approve'),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
