// lib/screens/post_job.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuveni_app/models/jobs.dart';
import 'package:kuveni_app/screens/profile_screen.dart'; // IMPORTANT: Import ProfileScreen

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobDescriptionController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _paymentDetailsController = TextEditingController();
  final TextEditingController _contactInfoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _jobTitleController.dispose();
    _jobDescriptionController.dispose();
    _requirementsController.dispose();
    _locationController.dispose();
    _paymentDetailsController.dispose();
    _contactInfoController.dispose();
    super.dispose();
  }

  void _postJob() async {
    if (_formKey.currentState!.validate()) {
      final newJob = Job(
        id: '',
        jobTitle: _jobTitleController.text,
        jobDescription: _jobDescriptionController.text,
        requirements: _requirementsController.text,
        location: _locationController.text,
        paymentDetails: _paymentDetailsController.text,
        contactInfo: _contactInfoController.text,
        postedDate: DateTime.now(),
      );

      try {
        CollectionReference jobs = FirebaseFirestore.instance.collection('jobs');
        await jobs.add(newJob.toFirestore());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job Posted Successfully!')),
        );
        Navigator.pop(context);
      } catch (e) {
        "Error posting job: $e";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post job: $e')),
        );
      }
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
              'Post a Job',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              // Profile Icon - Now functional
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
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField(
                controller: _jobTitleController,
                labelText: 'Job Title',
                hintText: 'e.g., Event Helper, Home Cleaner',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job title';
                  }
                  return null;
                },
              ),
              _buildInputField(
                controller: _jobDescriptionController,
                labelText: 'Job Description',
                hintText: 'Provide a detailed description of the job...',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job description';
                  }
                  return null;
                },
              ),
              _buildInputField(
                controller: _requirementsController,
                labelText: 'Requirements',
                hintText: 'List any specific skills or qualifications...',
                maxLines: 3,
              ),
              _buildInputField(
                controller: _locationController,
                labelText: 'Location',
                hintText: 'e.g., Colombo, Kandy, Online',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              _buildInputField(
                controller: _paymentDetailsController,
                labelText: 'Payment Details',
                hintText: 'e.g., LKR 5000/day, LKR 3000/task',
                keyboardType: TextInputType.text,
              ),
              _buildInputField(
                controller: _contactInfoController,
                labelText: 'Contact Information',
                hintText: 'e.g., Email, Phone Number',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact information';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _postJob,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5902B1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Post Job'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xFF5902B1), width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey[400]!, width: 1.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
