import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CircleAvatar(radius: 24, backgroundImage: AssetImage('assets/profile.jpg')),
                  Icon(Icons.notifications, color: Colors.white),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Good Morning, Christina!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              const Text("Sunday, June 29, 2025 - 2:30AM",
                  style: TextStyle(fontSize: 14, color: Colors.white)),
              const SizedBox(height: 4),
              const Text("Rise like Queen Kuveni 👑",
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white)),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner/Slideshow Section
            Container(
              height: 180,
              margin: const EdgeInsets.all(16),
              child: PageView(
                children: [
                  Image.asset('assets/banner1.jpg', fit: BoxFit.cover),
                  Image.asset('assets/banner2.jpg', fit: BoxFit.cover),
                  Image.asset('assets/banner3.jpg', fit: BoxFit.cover),
                ],
              ),
            ),
            // SOS and Mood Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _quickCard('SOS', Icons.sos, Colors.redAccent),
                  _quickCard('Mood', Icons.mood, Colors.purpleAccent),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Quick Action & Journey
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Quick-Action", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Image.asset('assets/your_own_light.png'),
                  const SizedBox(height: 12),
                  _journeyTodaySection(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Sri Lanka Map Image + Health Reminder
            Row(
              children: [
                Expanded(child: Image.asset('assets/srilanka_map.png', height: 150)),
                Expanded(child: _healthReminders()),
              ],
            ),
            const SizedBox(height: 16),
            // Inspire Personal Stories
            _inspireStories(),
            const SizedBox(height: 16),
            // Kuveni Challenge Wall
            _challengeWall(),
            const SizedBox(height: 16),
            // Spotlight Stories
            _spotlightStories(),
            const SizedBox(height: 16),
            // Quote of the Day
            _quoteOfDay(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
    currentIndex: 0,
    onTap: (index) {
      // Add navigation logic here
      if (index == 0) {
        // Already in Home, do nothing or refresh if needed
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/jobs');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/safety');
      } else if (index == 3) {
        Navigator.pushReplacementNamed(context, '/finance');
      } else if (index == 4) {
        Navigator.pushReplacementNamed(context, '/community');
      }
    },
  ),
    );
  }

  Widget _quickCard(String title, IconData icon, Color color) {
    return Card(
      color: color,
      child: SizedBox(
        height: 100,
        width: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(icon, color: Colors.white), Text(title, style: const TextStyle(color: Colors.white))],
          ),
        ),
      ),
    );
  }

  Widget _journeyTodaySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Journey Today", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          children: const [
            Chip(label: Text("1. Journal Entry")),
            Chip(label: Text("2. Reflect")),
            Chip(label: Text("3. Take Charge")),
            Chip(label: Text("4. Connect")),
            Chip(label: Text("5. Celebrate Wins")),
            Chip(label: Text("6. Hydration Check")),
          ],
        )
      ],
    );
  }

  Widget _healthReminders() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Health & Reminders", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("8:30 AM - Iron Supplement"),
          Text("3:00 PM - Check Symptoms"),
          Text("Daily Wellness Prompt"),
          Text("Hydration Check: 3 Glasses"),
        ],
      ),
    );
  }

  Widget _inspireStories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Inspire Personal Stories", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("\"I quit my toxic job...\""),
                  Row(children: [Icon(Icons.thumb_up), Icon(Icons.comment), Icon(Icons.share)]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _challengeWall() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Kuveni Challenge Wall", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("June Challenge - 2 of 4 completed"),
          Chip(label: Text("Mood Log (7 days)")),
          Chip(label: Text("Save LKR 500")),
        ],
      ),
    );
  }

  Widget _spotlightStories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Spotlight of Success stories", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _storyCard("Miss Shanika Perera", "Rural School Teacher", "Creating opportunities beyond..."),
          _storyCard("Dr. Anjali Nadakumar", "Community Health Advocate", "Healing not just children..."),
          _storyCard("Otara Gunewardene", "Founder of Odel", "Hope in the North"),
          ElevatedButton(onPressed: () {}, child: const Text("Read more stories"))
        ],
      ),
    );
  }

  Widget _storyCard(String name, String occupation, String tagline) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.person)),
        title: Text(name),
        subtitle: Text("$occupation\n$tagline"),
        trailing: IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
      ),
    );
  }

  Widget _quoteOfDay() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF54DB8), Color(0xFFEBB41F)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        '“They wrote me as a curse, but I was the power they feared.”\n— Queen Kuveni',
        style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
      ),
    );
  }
}

