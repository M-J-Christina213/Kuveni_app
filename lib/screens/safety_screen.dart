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
      children: [
        const Text("Safe Route", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(controller: startController, decoration: const InputDecoration(labelText: 'Start Location')),
        TextField(controller: endController, decoration: const InputDecoration(labelText: 'Destination')),
        const SizedBox(height: 12),
        isRouting
            ? Column(
                children: [
                  Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text("🗺️ Map showing safe route...")),
                  ),
                  const SizedBox(height: 10),
                  const Text("Distance: 6.4 km | ETA: 18 mins"),
                  ElevatedButton.icon(
                    onPressed: () => setState(() => isRouting = false),
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text("Exit"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  )
                ],
              )
            : ElevatedButton(
                onPressed: () => setState(() => isRouting = true),
                child: const Text("Start Safe Route"),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("🧠 General Safety", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("• Trust your instincts. If something feels off, leave."),
        Text("• Avoid sharing personal info online in real-time."),
        SizedBox(height: 10),
        Text("🚕 Travel Safety", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("• Share ride details with a trusted contact."),
        Text("• Sit in the back of taxis/ride-shares."),
        Text("• Check vehicle’s license plate before entering."),
        SizedBox(height: 10),
        Text("🚶‍♀️ Walking Alone", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("• Stick to well-lit streets."),
        Text("• Avoid distractions while walking."),
        Text("• Carry safety tools (if legal)."),
        SizedBox(height: 10),
        Text("📱 Phone Tips", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("• Keep emergency numbers on speed dial."),
        Text("• Enable location sharing with family/friends."),
        Text("• Keep phone charged."),
        SizedBox(height: 10),
        Text("🧍‍♀️ Public Places", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("• Be aware of exits."),
        Text("• Don’t leave drinks unattended."),
        Text("• Be cautious in elevators/stairwells."),
      ],
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
