// lib/models/job.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String id; // Document ID from Firestore
  final String jobTitle;
  final String jobDescription;
  final String requirements;
  final String location;
  final String paymentDetails;
  final String contactInfo;
  final DateTime postedDate;

  Job({
    this.id = '', // Default empty string for new jobs before Firestore assigns an ID
    required this.jobTitle,
    required this.jobDescription,
    required this.requirements,
    required this.location,
    required this.paymentDetails,
    required this.contactInfo,
    required this.postedDate,
  });

  // Factory constructor to create a Job object from a Firestore DocumentSnapshot
  factory Job.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Job(
      id: doc.id, // Get the document ID
      jobTitle: data['jobTitle'] ?? '',
      jobDescription: data['jobDescription'] ?? '',
      requirements: data['requirements'] ?? '',
      location: data['location'] ?? '',
      paymentDetails: data['paymentDetails'] ?? '',
      contactInfo: data['contactInfo'] ?? '',
      postedDate: (data['postedDate'] as Timestamp).toDate(), // Convert Timestamp to DateTime
    );
  }

  // Method to convert a Job object to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'requirements': requirements,
      'location': location,
      'paymentDetails': paymentDetails,
      'contactInfo': contactInfo,
      'postedDate': Timestamp.fromDate(postedDate), // Convert DateTime to Timestamp
    };
  }
}
