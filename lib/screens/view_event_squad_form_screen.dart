// lib/screens/view_event_squad_forms_screen.dart
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/event_squad_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewEventSquadFormsScreen extends StatefulWidget {
  const ViewEventSquadFormsScreen({super.key});

  @override
  State<ViewEventSquadFormsScreen> createState() => _ViewEventSquadFormsScreenState();
}

class _ViewEventSquadFormsScreenState extends State<ViewEventSquadFormsScreen> {
  // Supabase client instance
  final supabase = Supabase.instance.client;
  
  // Future to hold the result of the database fetch operation.
  late Future<List<Map<String, dynamic>>> _eventRequestsFuture;

  @override
  void initState() {
    super.initState();
    // Start fetching data as soon as the widget is initialized.
    _eventRequestsFuture = _fetchEventSquadForms();
  }

  // Asynchronous function to fetch data from the Supabase table.
  Future<List<Map<String, dynamic>>> _fetchEventSquadForms() async {
    try {
      // Query the 'event_squad_requests' table.
      // We order the results by 'created_at' in descending order to show the latest forms first.
      final List<Map<String, dynamic>> data = await supabase
          .from('event_squad_requests')
          .select()
          .order('created_at', ascending: false);

      return data;
    } on PostgrestException catch (e) {
      // Handle potential errors from Supabase.
      // In a real app, you would show a user-friendly error message.
      ('Error fetching data: $e');
      throw Exception('Failed to load event forms: ${e.message}');
    } catch (e) {
      // Catch any other unexpected errors.
      ('An unexpected error occurred: $e');
      throw Exception('An unexpected error occurred.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Event Squad Requests'),
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // The future we are waiting for.
        future: _eventRequestsFuture,
        builder: (context, snapshot) {
          // Check the state of the future.
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while fetching data.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If an error occurred, display an error message.
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If no data is returned, inform the user.
            return const Center(
              child: Text(
                'No event squad forms submitted yet.',
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            // Data has been successfully fetched. Build the list view.
            final List<Map<String, dynamic>> eventForms = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: eventForms.length,
              itemBuilder: (context, index) {
                final form = eventForms[index];
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: const Icon(Icons.event, color: Color(0xFF5902B1), size: 36),
                    title: Text(
                      form['event_name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    subtitle: Text(
                      'Helpers Required: ${form['helpers_required']}\nLocation: ${form['location']}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to a new screen to view the full details of the form.
                      // We pass the entire form map to the next screen.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventSquadForm(),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}