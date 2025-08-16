import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

class SubmitPremiumServiceScreen extends StatefulWidget {
  const SubmitPremiumServiceScreen({super.key});

  @override
  State<SubmitPremiumServiceScreen> createState() => _SubmitPremiumServiceScreenState();
}

class _SubmitPremiumServiceScreenState extends State<SubmitPremiumServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _providerNameController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactInfoController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  bool _isLoading = false;

  // Initialize Supabase client
  late final supa.SupabaseClient _supabaseClient;

  @override
  void initState() {
    super.initState();
    _supabaseClient = supa.Supabase.instance.client;
  }

  @override
  void dispose() {
    _serviceNameController.dispose();
    _providerNameController.dispose();
    _rateController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _contactInfoController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    // Check if the form is valid before proceeding
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final Map<String, dynamic> newService = {
          'service_name': _serviceNameController.text,
          'provider_name': _providerNameController.text,
          'rate': _rateController.text,
          'description': _descriptionController.text,
          'location': _locationController.text,
          'contact_info': _contactInfoController.text,
          'image_url': _imageUrlController.text,
          'rating': 0, // Default rating to 0
        };

        await _supabaseClient.from('premium_services').insert(newService);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Service submitted successfully!')),
          );
          // Navigate back to the previous screen
          Navigator.pop(context);
        }
      } on supa.PostgrestException catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.message}')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An unexpected error occurred: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Premium Service'),
        backgroundColor: const Color(0xFF5902B1),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _serviceNameController,
                decoration: const InputDecoration(labelText: 'Service Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a service name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _providerNameController,
                decoration: const InputDecoration(labelText: 'Provider Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a provider name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _rateController,
                decoration: const InputDecoration(labelText: 'Rate'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rate';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactInfoController,
                decoration: const InputDecoration(labelText: 'Contact Information'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact information';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                // Image URL is optional, so no validator needed.
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5902B1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Submit Service'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
