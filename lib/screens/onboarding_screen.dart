import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  List<Map<String, String>> onboardingData = [
    {
      "title": "Track Your Pet",
      "desc": "Monitor health, meals & appointments easily.",
    },
    {
      "title": "Explore Services",
      "desc": "Find pet care, grooming & nearby vets.",
    },
    {
      "title": "Join Community",
      "desc": "Connect with other pet lovers & share stories.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingData.length,
        onPageChanged: (index) => setState(() => currentIndex = index),
        itemBuilder: (context, index) => buildPage(
          title: onboardingData[index]["title"]!,
          desc: onboardingData[index]["desc"]!,
        ),
      ),
      bottomSheet: currentIndex == onboardingData.length - 1
          ? Container(
              height: 60,
              width: double.infinity,
              color: Colors.orange,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          : Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.orange.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text("Skip"),
                    onPressed: () {
                      _controller.jumpToPage(2);
                    },
                  ),
                  Row(
                    children: List.generate(
                      onboardingData.length,
                      (i) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == currentIndex
                              ? Colors.orange
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text("Next"),
                    onPressed: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

Widget buildPage({required String title, required String desc}) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pets, size: 100, color: Colors.orange),
          SizedBox(height: 30),
          Text(title,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Text(desc,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey[700])),
        ],
      ),
    );
  }
