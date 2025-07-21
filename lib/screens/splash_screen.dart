import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
const SplashScreen({super.key});

@override
State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
 void initState() {
   super.initState();

   // Delay for 3 seconds then navigate to Home
   Timer(const Duration(seconds: 3), () {
     Navigator.pushReplacementNamed(context, '/home');
   });
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: const Color(0xFF5902B1),
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           // Add your logo image here
           Image.asset('assets/kuveni_logo.jpg', height: 150),
           const SizedBox(height: 20),
           const Text(
             'Welcome to Kuveni',
             style: TextStyle(
               color: Colors.white,
               fontSize: 28,
               fontWeight: FontWeight.bold,
               letterSpacing: 2,
             ),
           ),
           const SizedBox(height: 12),
           const CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
           ),
         ],
       ),
     ),
   );
 }
}
