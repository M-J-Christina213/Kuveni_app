
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Initialize the Supabase client instance.
final supabase = Supabase.instance.client;

class EventSquadForm extends StatefulWidget {
  const EventSquadForm({super.key});

  @override
  _EventSquadFormState createState() => _EventSquadFormState();
}

class _EventSquadFormState extends State<EventSquadForm> {
  // GlobalKey for form validation.
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields.
  final _eventNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _helpersRequiredController = TextEditingController();
  final _typeOfHelpController = TextEditingController();
  final _contactController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoading = false;

  @override
  void dispose() {
    _eventNameController.dispose();
    _locationController.dispose();
    _helpersRequiredController.dispose();
    _typeOfHelpController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  // Function to show a date picker.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to show a time picker.
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Function to handle form submission and data insertion into Supabase.
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedDate != null && _selectedTime != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Combine date and time into a single DateTime object.
        final eventDateTime = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        );

        // Insert the data into the 'event_squad_requests' table.
        // Supabase will automatically generate the 'id' and 'created_at'.
        final response = await supabase.from('event_squad_requests').insert({
          'event_name': _eventNameController.text,
          'event_date': eventDateTime.toIso8601String(), // Correct format for Supabase timestamp
          'location': _locationController.text,
          'helpers_required': int.tryParse(_helpersRequiredController.text),
          'type_of_help': _typeOfHelpController.text,
          'contact': _contactController.text,
        });

        // The insert method doesn't return data, so we check for errors.
        if (response != null && response.error == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Event request submitted successfully!')),
          );
        } else if (response.error != null) {
          throw response.error!;
        }
      } catch (e) {
        // Show an error message if the submission fails.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Submission failed: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // Show an error message for incomplete forms.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields and select a date/time')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Squad Form'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _eventNameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the event name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              // Date picker field
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Event Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _selectedDate == null
                            ? 'Select Date'
                            : '${_selectedDate!.toLocal()}'.split(' ')[0],
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Time picker field
              InkWell(
                onTap: () => _selectTime(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Event Time',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _selectedTime == null
                            ? 'Select Time'
                            : _selectedTime!.format(context),
                      ),
                      const Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _helpersRequiredController,
                decoration: const InputDecoration(labelText: 'Helpers Required'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _typeOfHelpController,
                decoration: const InputDecoration(labelText: 'Type of Help'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the type of help needed';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Contact Information'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact information';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Submit Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
