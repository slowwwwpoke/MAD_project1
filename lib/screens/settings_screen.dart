import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Backup & Restore'),
            leading: Icon(Icons.backup),
          ),
          ListTile(
            title: Text('Set Default Currency'),
            leading: Icon(Icons.attach_money),
          ),
          ListTile(
            title: Text('Dark Mode'),
            leading: Icon(Icons.dark_mode),
          ),
          ListTile(
            title: Text('Privacy Policy'),
            leading: Icon(Icons.privacy_tip),
          ),
        ],
      ),
    );
  }
}
