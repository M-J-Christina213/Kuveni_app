// ignore_for_file: library_private_types_in_public_api, unused_element

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imagePaths = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
    'assets/images/banner4.webp',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: _buildAppBar(),  
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBannerSlider(),
          const SizedBox(height: 20),
          _buildSOSAndMoodCards(),
          const SizedBox(height: 20),
          const Text(
            "Quick Actions",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildQuickActionsSection(),
          const SizedBox(height: 20),
          _buildHealthAndRemindersSection(context),
          const SizedBox(height: 20),
          _buildInspireStoriesSection(),
          const SizedBox(height: 20),
          _buildChallengeWallSection(),
          const SizedBox(height: 20),
          _buildSpotlightStoriesSection(),
          const SizedBox(height: 20),
          _buildQuoteOfTheDaySection(),
        ],
      ),
    ),
    bottomNavigationBar: BottomNavBar(
      currentIndex: 0,
      onTap: (index) {
        if (index == 0) return;
        switch (index) {
          case 1:
            Navigator.pushReplacementNamed(context, '/jobs');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/safety');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/finance');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/community');
            break;
        }
      },
    ),
  );
}

  // 1) AppBar
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(130),
      child: Container(
        padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Profile + Greeting + Logout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/profile_pic.jfif'),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Good Morning, Christina!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/logout');
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            

            // Bottom Row: Date & Quote + Notifications Icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Sunday, June 29, 2025 - 2:30 AM",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Rise like Queen Kuveni 👑",
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    // handle notifications here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 2) Banner with PageController and dots
  Widget _buildBannerSlider() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: imagePaths.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(imagePaths.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 12 : 8,
              height: _currentPage == index ? 12 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.deepPurple : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }

  // 3) SOS and Mood Cards
  Widget _buildSOSAndMoodCards() {
  return Row(
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/safety');
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withAlpha(100),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🚨 SOS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Need help?\nTap to reach safety',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/community');
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withAlpha(100),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '😊 Mood',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Feeling something?\nTap to reflect or explore stories',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}


  // 4) Quick Actions Section
  Widget _buildQuickActionsSection() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/own_light.png',
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: _buildJourneyCard(),
        ),
      ],
    );
  }

  // 5) Journey Today Card
Widget _buildJourneyCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Journey Today",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),
        _buildJourneyStep(
          number: 1,
          title: "Breathe (5 min meditation)",
          isCompleted: true,
          isCurrent: false,
        ),
        _buildVerticalLine(),
        _buildJourneyStep(
          number: 2,
          title: "Reflect (Journal entry)",
          isCompleted: false,
          isCurrent: true,
        ),
        _buildVerticalLine(),
        _buildJourneyStep(
          number: 3,
          title: "Take charge (Self goal)",
          isGrey: true,
        ),
        _buildVerticalLine(),
        _buildJourneyStep(
          number: 4,
          title: "Connect (Reach out)",
          isGrey: true,
        ),
        _buildVerticalLine(),
        _buildJourneyStep(
          number: 5,
          title: "Celebrate win (Acknowledge)",
          isGrey: true,
        ),
      ],
    ),
  );
}

Widget _buildJourneyStep({
  required int number,
  required String title,
  bool isCompleted = false,
  bool isCurrent = false,
  bool isGrey = false,
}) {
  Color circleColor = isCompleted
      ? Colors.deepPurple
      : isCurrent
          ? Colors.deepPurple
          : Colors.grey;

  IconData icon = isCompleted
      ? Icons.check_circle
      : isCurrent
          ? Icons.radio_button_checked
          : Icons.radio_button_unchecked;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(icon, color: circleColor, size: 24),
        ],
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            title,
            style: TextStyle(
              color: isGrey ? Colors.grey : Colors.black,
              fontSize: 15,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildVerticalLine() {
  return Padding(
    padding: const EdgeInsets.only(left: 11.5), // align under icon
    child: Container(
      height: 24,
      width: 2,
      color: const Color.fromARGB(255, 129, 74, 232),
    ),
  );
}


 // 6 & 7) Sri Lanka Map + Health & Reminders side by side
Widget _buildHealthAndRemindersSection(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Left: Sri Lanka Map
      Expanded(
        flex: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/srilanka_map.png',
            height: screenHeight * 0.25, // 25% of screen height
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(width: 12),

      // Right: Health & Reminders Card
      Expanded(
        flex: 2,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(102, 255, 131, 150), // same as pink.withOpacity(0.4)
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "🩺 Health & Reminders",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.alarm, color: Colors.pink),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "8:30 AM – Don't forget your Iron supplement ✅",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.self_improvement, color: Colors.deepPurple),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "3:30 PM – Wellness Check 🔘\nHow is your energy today? Any symptoms?",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.edit_note, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    "+ Log how you feel",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.local_drink, color: Colors.blueAccent),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "💧 Hydration Check – You had 3 glasses today. Keep going!",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
}

  // 8) Inspire Personal Stories Section
  Widget _buildInspireStoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Inspire Personal Stories",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '“I quit my toxic job last month after 3 years of stress. Now I freelance as a content writer and feel free. The journey wasn’t easy, but worth every step.”',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Icon(Icons.favorite, color: Colors.red),
                  SizedBox(width: 8),
                  Text('24 likes · 5 comments'),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Refresh or add new story logic here
                  },
                  child: const Text("New Story"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 9) Kuveni Challenge Wall Section
  Widget _buildChallengeWallSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Kuveni Challenge Wall",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "June Challenge - 2 of 4 Completed",
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildChallengeSquare("😊", "Mood log (7 days)", gold: true),
                  _buildChallengeSquare("💰", "Save LKR 500", gold: true, purpleText: true),
                  _buildChallengeSquare("📧", "Letter to future self", grey: true),
                  _buildChallengeSquare("📖", "Add your own challenge", grey: true),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeSquare(String emoji, String label,
      {bool gold = false, bool grey = false, bool purpleText = false}) {
    Color bgColor = gold
        ? Colors.amber.shade300
        : (grey ? Colors.grey.shade300 : Colors.amber.shade100);
    Color textColor = purpleText
        ? Colors.purple
        : (grey ? Colors.grey : Colors.black);

    return Container(
      width: 140,
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 26),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // 10) Spotlight of Success Stories Section
  Widget _buildSpotlightStoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Spotlight of Success Stories",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        const SizedBox(height: 16),

        _buildSpotlightCard(
          imagePath: 'assets/images/spotlight1.jpg',
          name: 'Miss Shanika Perera',
          occupation: 'English Teacher, Monaragala District',
          tagline: 'Creating opportunities beyond the classroom for girls in remote Sri Lanka.',
        ),

        const SizedBox(height: 16),

        _buildSpotlightCard(
          imagePath: 'assets/images/spotlight2.jpg',
          name: 'Dr. Anjali Nandakumar',
          occupation: 'Pediatric Doctor, Jaffna General Hospital',
          tagline: 'Healing not just children, but generations of hope in the North.',
        ),

        const SizedBox(height: 16),

        _buildSpotlightCard(
          imagePath: 'assets/images/spotlight3.jfif',
          name: 'Otara Gunewardene',
          occupation: 'Businesswoman, Philanthropist, Animal Rights Activist',
          tagline: 'Paving new paths where compassion meets commerce.',
          isLast: true,
        ),

        const SizedBox(height: 16),

        Center(
          child: OutlinedButton(
            onPressed: () {
              // Load more stories
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.pink),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text(
              'Read More Stories',
              style: TextStyle(color: Colors.pink),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpotlightCard({
    required String imagePath,
    required String name,
    required String occupation,
    required String tagline,
    bool isLast = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(occupation, style: const TextStyle(color: Colors.black54)),
                      const SizedBox(height: 8),
                      Text(tagline),
                    ],
                  ),
                ),
                Icon(
                  Icons.favorite,
                  color: isLast ? Colors.red : Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Read story
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Read Her Story'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Connect action
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.purple),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      foregroundColor: Colors.purple,
                    ),
                    child: const Text('Connect'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 11) Quote of the Day Section
  Widget _buildQuoteOfTheDaySection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.pink.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        '“They wrote me as a curse, but I was the power they feared.”\n— Queen Kuveni',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
