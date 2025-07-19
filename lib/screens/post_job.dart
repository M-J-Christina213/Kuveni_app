import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({Key? key}) : super(key: key);

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  // Variables
  String? _selectedCategory;
  DateTime? _selectedDeadline;

  // Sample categories
  final List<String> _categories = [
    'Housekeeping',
    'Babysitting',
    'Gardening',
    'Cooking',
    'Caregiving',
    'Tutoring',
    'Other',
  ];

  // Function to show date picker
  Future<void> _pickDeadline() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDeadline = picked;
      });
    }
  }

  // Submit handler
  void _submitJob() {
    if (_formKey.currentState!.validate()) {
      // Here you would normally send this data to a backend or database
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Job Posted Successfully!')),
      );
      // Clear form
      _formKey.currentState!.reset();
      _selectedCategory = null;
      _selectedDeadline = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Job'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Job Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Job Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a job title' : null,
              ),

              // Job Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Job Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a job description' : null,
              ),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
              ),

              // Location
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a location' : null,
              ),

              // Budget
              TextFormField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Budget (LKR)'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your budget' : null,
              ),

              // Deadline Date Picker
              InkWell(
                onTap: _pickDeadline,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Deadline',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDeadline != null
                            ? DateFormat('yyyy-MM-dd').format(_selectedDeadline!)
                            : 'Pick a deadline',
                        style: TextStyle(
                          color: _selectedDeadline != null
                              ? Colors.black
                              : Colors.grey[600],
                        ),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Contact Number
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Contact Number'),
                validator: (value) => value!.length < 10
                    ? 'Enter a valid contact number'
                    : null,
              ),

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitJob,
                  icon: const Icon(Icons.check),
                  label: const Text('Submit Job'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}