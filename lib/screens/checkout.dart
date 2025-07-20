// lib/screens/checkout.dart
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Controllers for input fields
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _billingAddressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cardNameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _billingAddressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, process payment (placeholder logic)
      'Processing Payment:';
      'Card Name: ${_cardNameController.text}';
      'Card Number: ${_cardNumberController.text}';
      'Expiry Date: ${_expiryDateController.text}';
      'CVV: ${_cvvController.text}';
      'Billing Address: ${_billingAddressController.text}';
      'City: ${_cityController.text}';
      'Zip Code: ${_zipCodeController.text}';

      // For now, just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment Processed Successfully!')),
      );
      // Optionally navigate back or to a confirmation screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar with gradient background
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
              'Checkout',
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
                 
                  'Profile icon tapped from Checkout';
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
                'Payment Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 15),
              _buildInputField(
                controller: _cardNameController,
                labelText: 'Name on Card',
                hintText: 'e.g., John Doe',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter name on card';
                  return null;
                },
              ),
              _buildInputField(
                controller: _cardNumberController,
                labelText: 'Card Number',
                hintText: 'XXXX XXXX XXXX XXXX',
                keyboardType: TextInputType.number,
                maxLength: 16,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 16) return 'Please enter a valid 16-digit card number';
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _expiryDateController,
                      labelText: 'Expiry Date',
                      hintText: 'MM/YY',
                      keyboardType: TextInputType.datetime,
                      maxLength: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty || !RegExp(r'^\d{2}\/\d{2}$').hasMatch(value)) return 'Format MM/YY';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInputField(
                      controller: _cvvController,
                      labelText: 'CVV',
                      hintText: 'XXX',
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length != 3) return 'Enter 3-digit CVV';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Billing Address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 15),
              _buildInputField(
                controller: _billingAddressController,
                labelText: 'Address Line 1',
                hintText: 'e.g., 123 Main St',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter billing address';
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _cityController,
                      labelText: 'City',
                      hintText: 'e.g., Colombo',
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter city';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInputField(
                      controller: _zipCodeController,
                      labelText: 'Zip Code',
                      hintText: 'e.g., 00100',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _processPayment,
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
                  child: const Text('Confirm Payment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable input field helper
  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
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
            maxLength: maxLength,
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
              counterText: "", // Hide the default maxLength counter
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
