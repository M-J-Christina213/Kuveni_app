// lib/screens/job_huntlist.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

class JobHuntListScreen extends StatefulWidget {
  const JobHuntListScreen({super.key});

  @override
  State<JobHuntListScreen> createState() => _JobHuntListScreenState();
}

class _JobHuntListScreenState extends State<JobHuntListScreen> {
  // State variables to hold the fetched data and manage the loading state.
  List<dynamic> _jobs = [];
  bool _isLoading = true;

  // Initialize the Supabase client within the state
  late final supa.SupabaseClient _supabaseClient;

  @override
  void initState() {
    super.initState();
    _supabaseClient = supa.Supabase.instance.client;
    _fetchJobs();
  }

  // Function to fetch all jobs from the 'general_jobs' table.
  Future<void> _fetchJobs() async {
    try {
      final response = await _supabaseClient
          .from('general_jobs')
          .select()
          .order('created_at', ascending: false); // Order by creation date to show recent jobs first.

      setState(() {
        _jobs = response;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch jobs: $e')),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
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
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Available Jobs',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 30),
                onPressed: () {
                  // This screen needs to be implemented.
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _jobs.isEmpty
              ? const Center(
                  child: Text('No jobs available yet.', style: TextStyle(fontSize: 16)),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _jobs.length,
                  itemBuilder: (context, index) {
                    final job = _jobs[index];
                    return JobCard(
                      job: job,
                      onTap: () {
                        // Navigate to the detail screen and pass the job data.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewJobVacancyScreen(
                              jobTitle: job['job_title'] ?? 'N/A',
                              company: job['contact_info'] ?? 'N/A',
                              location: job['location'] ?? 'N/A',
                              salary: job['payment_details'] ?? 'N/A',
                              description: job['job_description'] ?? 'N/A',
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}

// A simple placeholder for the job vacancy screen
class ViewJobVacancyScreen extends StatelessWidget {
  final String jobTitle;
  final String company;
  final String location;
  final String salary;
  final String description;

  const ViewJobVacancyScreen({
    super.key,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.salary,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jobTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Company: $company', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Location: $location', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Salary: $salary', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text('Description:', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(description),
          ],
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Map<String, dynamic> job;
  final VoidCallback onTap;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job['job_title'] ?? 'N/A',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5902B1),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    job['location'] ?? 'N/A',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.monetization_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    job['payment_details'] ?? 'N/A',
                    style: const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
