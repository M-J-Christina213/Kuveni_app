// lib/screens/create_group_screen.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuveni_app/screens/profile_screen.dart'; // For the main profile icon

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _groupDescriptionController = TextEditingController();
  final TextEditingController _groupRulesController = TextEditingController();
  final TextEditingController _groupImageController = TextEditingController(); // For image URL

  bool _isLoading = false;

  @override
  void dispose() {
    _groupNameController.dispose();
    _groupDescriptionController.dispose();
    _groupRulesController.dispose();
    _groupImageController.dispose();
    super.dispose();
  }

  Future<void> _createGroup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseFirestore.instance.collection('community_groups').add({
          'name': _groupNameController.text.trim(),
          'description': _groupDescriptionController.text.trim(),
          'rules': _groupRulesController.text.trim(),
          'image': _groupImageController.text.trim().isEmpty
              ? 'https://placehold.co/60x60/CCCCCC/000000?text=Group' // Default placeholder if no image provided
              : _groupImageController.text.trim(),
          'members': 1, // Creator is the first member
          'adminId': 'current_user_id', 
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Community Group Created Successfully!')),
        );
        Navigator.pop(context); // Go back to community list
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating group: ${e.toString()}')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  // Helper for consistent TextFormField
  Widget _buildTextFormField({
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
              'Create New Group',
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
              _buildTextFormField(
                controller: _groupNameController,
                labelText: 'Group Name',
                hintText: 'e.g., Daily Meditations, Book Club',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Group name is required';
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _groupDescriptionController,
                labelText: 'Group Description',
                hintText: 'Tell us what your group is about...',
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Group description is required';
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _groupRulesController,
                labelText: 'Group Rules (Optional)',
                hintText: 'e.g., Be respectful, No spamming',
                maxLines: 3,
              ),
              _buildTextFormField(
                controller: _groupImageController,
                labelText: 'Group Image URL (Optional)',
                hintText: 'Paste an image URL for your group icon',
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 30),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator(color: Color(0xFFEBB41F))
                    : ElevatedButton(
                        onPressed: _createGroup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEBB41F),
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
                        child: const Text('Create Group'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}