import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SafetyScreen extends StatefulWidget {
  const SafetyScreen({super.key});

  @override
  State<SafetyScreen> createState() => _SafetyScreenState();
}

class _SafetyScreenState extends State<SafetyScreen> {
  bool showSafeRoute = false;
  bool showTravelCheckIn = false;
  bool showSafetyTips = false;

  // Safe Route
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  bool isRouting = false;

  // Travel Check-Ins
  List<Map<String, String>> contacts = [
    {'name': 'Bhagya', 'phone': '0771234567'},
    {'name': 'Jethuni', 'phone': '0777654321'},
  ];
  String? sharedWith;

  void _addContactDialog() {
    String name = '';
    String phone = '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              onChanged: (value) => phone = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (name.isNotEmpty && phone.isNotEmpty) {
                setState(() => contacts.add({'name': name, 'phone': phone}));
              }
              Navigator.pop(ctx);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _removeContactDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Remove Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: contacts
              .map((contact) => ListTile(
                    title: Text(contact['name']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() => contacts.remove(contact));
                        Navigator.pop(ctx);
                      },
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _shareLocation(String name, String phone) async {
    String locationLink = "https://maps.google.com/?q=LiveLocationOfUser"; // Dummy link
    await launchUrl(Uri.parse("sms:$phone?body=Live location shared: $locationLink"));
    setState(() => sharedWith = name);
  }

  void _stopSharing() {
    setState(() => sharedWith = null);
  }

  Widget _buildSafeRouteSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "🚦 Safe Route",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 12),
      TextField(
        controller: startController,
        decoration: const InputDecoration(
          labelText: 'Start Location',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: endController,
        decoration: const InputDecoration(
          labelText: 'Destination',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 20),
      isRouting
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/map.jpeg',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Icon(Icons.my_location, color: Colors.purple),
                    SizedBox(width: 8),
                    Text("Start: Colombo Fort", style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.flag, color: Colors.deepPurple),
                    SizedBox(width: 8),
                    Text("Destination: Nugegoda", style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Column(
                        children: [
                          Icon(Icons.directions_walk, color: Colors.deepPurple),
                          SizedBox(height: 4),
                          Text("6.4 km"),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.timer, color: Colors.deepPurple),
                          SizedBox(height: 4),
                          Text("18 mins"),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.shield, color: Colors.green),
                          SizedBox(height: 4),
                          Text("High Safety"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => setState(() => isRouting = false),
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text("Exit Safe Route"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: ElevatedButton.icon(
                onPressed: () => setState(() => isRouting = true),
                icon: const Icon(Icons.map),
                label: const Text("Start Safe Route"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
              ),
            ),
    ],
  );
}


  Widget _buildTravelCheckInSection() {
    return Column(
      children: [
        const Text("Travel Check-ins", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...contacts.map((c) => ListTile(
              title: Text(c['name']!),
              subtitle: Text(c['phone']!),
              trailing: sharedWith == c['name']
                  ? ElevatedButton(
                      onPressed: _stopSharing,
                      child: const Text("Stop Sharing"),
                    )
                  : ElevatedButton(
                      onPressed: () => _shareLocation(c['name']!, c['phone']!),
                      child: const Text("Share Location"),
                    ),
            )),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: _addContactDialog,
              icon: const Icon(Icons.person_add),
              label: const Text("Add Contact"),
            ),
            ElevatedButton.icon(
              onPressed: _removeContactDialog,
              icon: const Icon(Icons.delete),
              label: const Text("Remove Contact"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSafetyTipsSection() {
  final sectionData = [
    {
      "emoji": "🧠",
      "title": "General Safety",
      "tips": [
        "Trust your instincts. If something feels off, leave.",
        "Avoid sharing personal info online in real-time.",
      ],
    },
    {
      "emoji": "🚕",
      "title": "Travel Safety",
      "tips": [
        "Share ride details with a trusted contact.",
        "Sit in the back of taxis/ride-shares.",
        "Check vehicle’s license plate before entering.",
      ],
    },
    {
      "emoji": "🚶‍♀️",
      "title": "Walking Alone",
      "tips": [
        "Stick to well-lit streets.",
        "Avoid distractions while walking.",
        "Carry safety tools (if legal).",
      ],
    },
    {
      "emoji": "📱",
      "title": "Phone Tips",
      "tips": [
        "Keep emergency numbers on speed dial.",
        "Enable location sharing with family/friends.",
        "Keep phone charged.",
      ],
    },
    {
      "emoji": "🧍‍♀️",
      "title": "Public Places",
      "tips": [
        "Be aware of exits.",
        "Don’t leave drinks unattended.",
        "Be cautious in elevators/stairwells.",
      ],
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: sectionData.map((section) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.pink.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade100,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${section['emoji']} ${section['title']}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            ...(section['tips'] as List<String>).map((tip) => Row(
                  children: [
                    const Text("• ",
                        style: TextStyle(fontSize: 16, color: Colors.black87)),
                    Expanded(
                      child: Text(
                        tip,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      );
    }).toList(),
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
              colors: [Color(0xFF5902B1), Color(0xFF700DB2), Color(0xFFF54DB8), Color(0xFFEBB41F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Safety',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 30),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showSafeRoute = true;
                  showTravelCheckIn = false;
                  showSafetyTips = false;
                });
              },
              child: const Text("Safe Routes"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showSafeRoute = false;
                  showTravelCheckIn = true;
                  showSafetyTips = false;
                });
              },
              child: const Text("Travel Check-ins"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showSafeRoute = false;
                  showTravelCheckIn = false;
                  showSafetyTips = true;
                });
              },
              child: const Text("General Safety Tips"),
            ),
            const SizedBox(height: 20),
            if (showSafeRoute) _buildSafeRouteSection(),
            if (showTravelCheckIn) _buildTravelCheckInSection(),
            if (showSafetyTips) _buildSafetyTipsSection(),
          ],
        ),
      ),
    );
  }
}
