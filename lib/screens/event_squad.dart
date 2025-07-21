// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kuveni_app/screens/profile_screen.dart'; // IMPORTANT: Import ProfileScreen

class EventSquadForm extends StatefulWidget {
  const EventSquadForm({super.key});

  @override
  State<EventSquadForm> createState() => _EventSquadFormState();
}

class _EventSquadFormState extends State<EventSquadForm> {
  final _formKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _helpersController = TextEditingController();
  final _helpTypeController = TextEditingController();
  final _contactController = TextEditingController();

  DateTime? _selectedDate;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      try {
        await FirebaseFirestore.instance.collection('event_squad_requests').add({
          'event_name': _eventNameController.text,
          'event_date': _selectedDate!.toIso8601String(),
          'location': _locationController.text,
          'helpers_required': int.parse(_helpersController.text),
          'type_of_help': _helpTypeController.text,
          'contact': _contactController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully!')),
        );

        _formKey.currentState!.reset();
        setState(() {
          _selectedDate = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
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
              'Event Squad Form',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField(
                controller: _eventNameController,
                labelText: 'Event Name',
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => _pickDate(context),
                child: InputDecorator(
                  decoration: _inputDecoration('Date of Event'),
                  child: Text(
                    _selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                        : 'Select Date',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTextFormField(
                controller: _locationController,
                labelText: 'Location',
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              _buildTextFormField(
                controller: _helpersController,
                labelText: 'Number of Helpers Required',
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty || int.tryParse(value) == null ? 'Enter a valid number' : null,
              ),
              const SizedBox(height: 10),
              _buildTextFormField(
                controller: _helpTypeController,
                labelText: 'Type of Help Needed',
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              _buildTextFormField(
                controller: _contactController,
                labelText: 'Contact of Person in Charge',
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty || value.length < 10 ? 'Enter a valid contact number' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEBB41F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF700DB2), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(labelText),
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }
}
