// lib/screens/setgoal.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class SetGoalPage extends StatefulWidget {
  const SetGoalPage({super.key});

  @override
  State<SetGoalPage> createState() => _SetGoalPageState();
}

class _SetGoalPageState extends State<SetGoalPage> {
  // Controllers for input fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _targetAmountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose all controllers to free up resources
    _titleController.dispose();
    _targetAmountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Function to handle form submission and save to Firebase (placeholder)
  void _saveGoal() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, process the data
      print('Goal Title: ${_titleController.text}');
      print('Target Amount: ${_targetAmountController.text}');
      print('Description: ${_descriptionController.text}');

      // TODO: Implement actual goal saving logic to Firebase Firestore
      try {
        await FirebaseFirestore.instance.collection('goals').add({
          'title': _titleController.text,
          'targetAmount': double.parse(_targetAmountController.text), // Convert to double
          'description': _descriptionController.text,
          'savedAmount': 0.0, // Initialize saved amount to 0
          'createdAt': FieldValue.serverTimestamp(), // Timestamp for when the goal was created
          // You might add a userId here if you have authentication
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Goal Saved Successfully!')),
        );
        Navigator.pop(context); // Go back to the GoalsPage
      } catch (e) {
        print("Error saving goal: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save goal: ${e.toString()}')),
        );
      }
    }
  }

  // Reusable input field helper
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
              'Set New Goal', // Changed title to be more specific
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
                  // TODO: Navigate to profile screen
                  print('Profile icon tapped from Set Goal');
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
              const Text(
                "Hello, Bhagya",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const Text(
                "Set your new financial goal",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              _buildInputField(
                controller: _titleController,
                labelText: 'Goal Title',
                hintText: 'e.g., New Car, House Down Payment',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a goal title';
                  return null;
                },
              ),
              _buildInputField(
                controller: _targetAmountController,
                labelText: 'Target Amount (LKR)',
                hintText: 'e.g., 2500000',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a target amount';
                  if (double.tryParse(value) == null) return 'Please enter a valid number';
                  return null;
                },
              ),
              _buildInputField(
                controller: _descriptionController,
                labelText: 'More Info (Optional)',
                hintText: 'Add any additional details about your goal...',
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _saveGoal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEBB41F), // Orange/Yellow from your gradient
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
                  child: const Text('SAVE GOAL'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
