import 'package:flutter/material.dart';

class JobScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jobs')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Job Hunt Section
                _createListTile(
                  context,
                  title: 'Job Hunt',
                  subtitle: 'Browse listings with filters',
                  destination: JobHuntScreen(),
                ),
                // Premium Services Section
                _createListTile(
                  context,
                  title: 'Premium Services',
                  subtitle: 'Hire skilled individuals with top services',
                  destination: PremiumServicesScreen(),
                ),
                // Event Squad Section
                _createListTile(
                  context,
                  title: 'Event Squad',
                  subtitle: 'Book a team of helpers',
                  destination: EventSquadScreen(),
                ),
              ],
            ),
          ),
          // Buttons
          _createActionButtons(context),
        ],
      ),
    );
  }

  // Helper method to create a list tile
  Widget _createListTile(BuildContext context, {required String title, required String subtitle, required Widget destination}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
      },
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

  // Helper method to create action buttons
  Widget _createActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PostJobScreen()));
          },
          child: Text('Post Job'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BuyPremiumScreen()));
          },
          child: Text('Buy Premium'),
        ),
      ],
    );
  }
}