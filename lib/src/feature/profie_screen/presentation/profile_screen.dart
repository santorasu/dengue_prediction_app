import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName = "Md. Rashedul Islam";
  final String email = "rashedul.cse.engineer@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfo(),
            Divider(height: 40),
            _buildSettingsSection(context),
            Divider(height: 40),
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 36,
          child: Icon(Icons.person, size: 48),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(email, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SwitchListTile(
          title: Text('Dark Mode (placeholder)'),
          value: false,
          onChanged: (val) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Dark mode toggle not implemented')));
          },
        ),
        ListTile(
          title: Text('Units'),
          subtitle: Text('Metric (default)'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Units selection not implemented')));
          },
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text(
          'Dengue Prediction App v1.0\n'
              'Developed for early detection of dengue fever using hematological data.\n'
              'Made with Flutter.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
