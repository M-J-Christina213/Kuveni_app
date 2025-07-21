// ignore_for_file: library_private_types_in_public_api, unused_element, deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kuveni_app/screens/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imagePaths = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.png',
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
          buildResponsiveLayout(context),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                    );
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
          height: 200,
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
Widget buildResponsiveLayout(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth > 600) {
    // Tablet/Desktop layout (side-by-side)
    return Column(
      children: [
        _buildQuickActionsSection(),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: _buildHealthAndRemindersCard()),
            const SizedBox(width: 16),
            Expanded(flex: 1, child: _buildSriLankaMap()),
          ],
        ),
      ],
    );
  } else {
    // Phone layout (vertical stacked)
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildQuickActionsSection(),            // 1 + 2
          const SizedBox(height: 24),
          _buildHealthAndRemindersCard(),        // 3
          const SizedBox(height: 24),
          _buildSriLankaMap(),                   // 4
        ],
      ),
    );
  }
}

Widget _buildQuickActionsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildJourneyCard(), 
      const SizedBox(height: 20),
      ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/anudi.jpg',
          height: 350,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    ],
  );
}


  // 5) Journey Today Card
Widget _buildJourneyCard() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 122, 41, 252),  
          Color.fromARGB(255, 255, 77, 196),  
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withAlpha((0.3 * 255).round()),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Journey Today",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black38,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Journey Steps
        _buildJourneyStep(
          number: 1,
          title: "Breathe (5 min meditation)",
          isCompleted: true,
          isCurrent: false,
          completedColor: Colors.tealAccent.shade200,
        ),
        _buildVerticalLine(color: Colors.tealAccent.shade200),
        _buildJourneyStep(
          number: 2,
          title: "Reflect (Journal entry)",
          isCompleted: false,
          isCurrent: true,
          currentColor: Colors.amberAccent.shade200,
        ),
        _buildVerticalLine(color: Colors.amberAccent.shade200),
        _buildJourneyStep(
          number: 3,
          title: "Take charge (Self goal)",
          isGrey: true,
        ),
        _buildVerticalLine(color: Colors.grey.shade400),
        _buildJourneyStep(
          number: 4,
          title: "Connect (Reach out)",
          isGrey: true,
        ),
        _buildVerticalLine(color: Colors.grey.shade400),
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
  Color? completedColor,
  Color? currentColor,
}) {
  final Color activeCompletedColor = completedColor ?? Colors.deepPurpleAccent.shade200;
  final Color activeCurrentColor = currentColor ?? Colors.deepPurpleAccent.shade100;

  Color circleColor = isCompleted
      ? activeCompletedColor
      : isCurrent
          ? activeCurrentColor
          : Colors.grey.shade400;

  IconData icon = isCompleted
      ? Icons.check_circle
      : isCurrent
          ? Icons.radio_button_checked
          : Icons.radio_button_unchecked;

  Color textColor = isGrey ? Colors.grey.shade300 : Colors.white;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(icon, color: circleColor, size: 28),
        ],
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
              shadows: isGrey
                  ? null
                  : const [
                      Shadow(
                        blurRadius: 2,
                        color: Colors.black26,
                        offset: Offset(0.5, 0.5),
                      ),
                    ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildVerticalLine({Color? color}) {
  return Padding(
    padding: const EdgeInsets.only(left: 14, bottom: 6),
    child: Container(
      height: 28,
      width: 3,
      decoration: BoxDecoration(
        color: color ?? Colors.deepPurpleAccent.shade100,
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );
}


// 6 & 7) Sri Lanka Map + Health & Reminders 
// Health & Reminders Card 
Widget _buildHealthAndRemindersCard() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.pink.shade200,
          Colors.pink.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.pink.withAlpha(60),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "🩺 Health & Reminders",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 8,
                color: Colors.black26,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        _buildHealthRow(Icons.alarm, Colors.white, "8:30 AM – Don't forget your Iron supplement ✅"),
        const SizedBox(height: 16),

        _buildHealthRow(Icons.self_improvement, Colors.white, "3:30 PM – Wellness Check 🔘\nHow is your energy today? Any symptoms?"),
        const SizedBox(height: 16),

        _buildHealthRow(Icons.edit_note, Colors.white, "+ Log how you feel", isBold: true),
        const SizedBox(height: 16),

        _buildHealthRow(Icons.local_drink, Colors.white, "💧 Hydration Check – You had 3 glasses today. Keep going!"),
      ],
    ),
  );
}

Widget _buildHealthRow(IconData icon, Color iconColor, String text, {bool isBold = false}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: iconColor, size: 28),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            height: 1.3,
          ),
        ),
      ),
    ],
  );
}

// Sri Lanka Map - larger and full visible
Widget _buildSriLankaMap() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
      'assets/images/srilanka_map.png',
      height: 550, 
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  );
}

// Usage inside your build:
Widget _buildHealthAndMapSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildHealthAndRemindersCard(),
      const SizedBox(height: 24),
      _buildSriLankaMap(),
    ],
  );
}
}
// 8) Inspire Personal Stories Section (Redesigned)
Widget _buildInspireStoriesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Inspire Personal Stories",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple[700],
            ),
          ),
        ),
      ),
      const SizedBox(height: 16),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withAlpha(50),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.format_quote, color: Colors.deepPurple, size: 30),
            const SizedBox(height: 8),
            const Text(
              '“I quit my toxic job last month after 3 years of stress. '
              'Now I freelance as a content writer and feel free. The journey '
              'wasn’t easy, but worth every step.”',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.favorite, color: Colors.pinkAccent),
                SizedBox(width: 6),
                Text('24 likes · 5 comments',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  // New story logic here
                },
                icon: const Icon(Icons.add),
                label: const Text("New Story"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
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
            LayoutBuilder(
              builder: (context, constraints) {
                double cardWidth = (constraints.maxWidth - 24) / 2; // 12 spacing * 1
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildChallengeSquare("😊", "Mood log (7 days)", cardWidth, gold: true),
                    _buildChallengeSquare("💰", "Save LKR 500", cardWidth, gold: true, purpleText: true),
                    _buildChallengeSquare("📧", "Letter to future self", cardWidth, grey: true),
                    _buildChallengeSquare("📖", "Add your own challenge", cardWidth, grey: true),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    ],
  );
}


Widget _buildChallengeSquare(String emoji, String label, double width,
    {bool gold = false, bool grey = false, bool purpleText = false}) {
  Color bgColor = gold
      ? Colors.amber.shade300
      : (grey ? Colors.grey.shade300 : Colors.amber.shade100);
  Color textColor = purpleText
      ? Colors.purple
      : (grey ? Colors.grey.shade800 : Colors.black87);

  return Container(
    width: width,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 203, 30, 234).withAlpha(60), // softer purple shadow
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
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
      const SizedBox(height: 20),

      _buildSpotlightCard(
        imagePath: 'assets/images/spotlight1.jpg',
        name: 'Miss Shanika Perera',
        occupation: 'English Teacher, Monaragala District',
        tagline: 'Creating opportunities beyond the classroom for girls in remote Sri Lanka.',
      ),
      const SizedBox(height: 20),

      _buildSpotlightCard(
        imagePath: 'assets/images/spotlight2.jpg',
        name: 'Dr. Anjali Nandakumar',
        occupation: 'Pediatric Doctor, Jaffna General Hospital',
        tagline: 'Healing not just children, but generations of hope in the North.',
      ),
      const SizedBox(height: 20),

      _buildSpotlightCard(
        imagePath: 'assets/images/spotlight3.jfif',
        name: 'Otara Gunewardene',
        occupation: 'Businesswoman, Philanthropist, Animal Rights Activist',
        tagline: 'Paving new paths where compassion meets commerce.',
        isLast: true,
      ),

      const SizedBox(height: 24),

      Center(
        child: OutlinedButton.icon(
          onPressed: () {
            // Load more stories
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.purple),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          icon: const Icon(Icons.arrow_forward, color: Colors.purple),
          label: const Text(
            'Read More Stories',
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w600),
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
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withAlpha(30),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              imagePath,
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.deepPurple,
                        )),
                    const SizedBox(height: 4),
                    Text(occupation,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        )),
                    const SizedBox(height: 10),
                    Text(tagline,
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.favorite,
                color: isLast ? Colors.red : Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Read story
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Read Her Story',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Connect
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.purple),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    foregroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 244, 146, 181), // light pink
          Color.fromARGB(255, 222, 67, 119), // mid pink
          Color.fromARGB(255, 218, 42, 101), // deep pink
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.pink.shade100.withOpacity(0.4),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: const Text(
      '“They wrote me as a curse, but I was the power they feared.”\n— Queen Kuveni',
      style: TextStyle(
        fontFamily: 'Georgia', // default elegant serif
        color: Colors.white,
        fontSize: 20,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w600,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

