/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nicController = TextEditingController();
  DateTime? _selectedDOB;

  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Firebase Authentication
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

      // Save additional details to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user!.uid)
          .set({
        'email': _emailController.text.trim(),
        'username': _usernameController.text.trim(),
        'nic': _nicController.text.trim(),
        'dob': _selectedDOB?.toIso8601String(),
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful!')),
      );

      // Navigate to Home or Login screen
      // Navigator.pushReplacement(...);

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _pickDOB() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDOB = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA678B4), // light purple background
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField("Email", _emailController,
                      validator: (value) =>
                          value!.contains('@') ? null : 'Enter valid email'),
                  _buildTextField("Username", _usernameController,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter a username' : null),
                  _buildTextField("Password", _passwordController,
                      obscure: true,
                      validator: (value) =>
                          value!.length >= 6 ? null : 'Min 6 characters'),
                  _buildTextField("NIC", _nicController,
                      validator: (value) =>
                          value!.length >= 10 ? null : 'Invalid NIC'),
                  GestureDetector(
                    onTap: _pickDOB,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      width: double.infinity,
                      child: Text(
                        _selectedDOB == null
                            ? 'Select DOB'
                            : '${_selectedDOB!.toLocal()}'
                                .split(' ')[0],
                        style: TextStyle(
                            color: _selectedDOB == null
                                ? Colors.grey
                                : Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 40)),
                          onPressed: _register,
                          child: Text('Register'),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscure = false, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

*/