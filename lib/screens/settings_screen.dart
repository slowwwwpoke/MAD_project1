import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).iconTheme.color!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        iconTheme: IconThemeData(color: iconColor),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.dark_mode, color: iconColor),
            title: const Text('Toggle Dark Mode'),
            onTap: () {
              // Toggle the theme using the ThemeProvider
              final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
              themeProvider.toggleTheme();
            },
          ),
          // Add other ListTiles for backup, restore, etc.
        ],
      ),
    );
  }
}
