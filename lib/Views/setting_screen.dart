import 'package:expence_manager/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;
  bool _darkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
      _darkModeEnabled = prefs.getBool('darkModeEnabled') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationsEnabled', _notificationsEnabled);
    prefs.setBool('darkModeEnabled', _darkModeEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Setting', onBackPressed: () {
        Navigator.of(context).pop();
      },

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildSectionHeader('Preferences', context),
            buildSwitchTile(
              title: 'Enable Notifications',
              value: _notificationsEnabled,
              icon: Icons.notifications_active_outlined,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                _saveSettings();
              },
              context: context,
            ),
            buildSwitchTile(
              title: 'Enable Dark Mode',
              value: _darkModeEnabled,
              icon: Icons.dark_mode_outlined,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
                _saveSettings();
              },
              context: context,
            ),
            SizedBox(height: 20),
            buildSectionHeader('Account', context),
            buildListTile(
              title: 'Account Settings',
              subtitle: 'Manage your account settings',
              icon: Icons.account_circle_outlined,
              onTap: () {
                // Navigate to account settings screen
              },
              context: context,
            ),
            buildListTile(
              title: 'Privacy',
              subtitle: 'Manage your privacy settings',
              icon: Icons.privacy_tip_outlined,
              onTap: () {
                // Navigate to privacy settings screen
              },
              context: context,
            ),
            SizedBox(height: 20),
            buildSectionHeader('Support', context),
            buildListTile(
              title: 'Help & Support',
              subtitle: 'Get help and support',
              icon: Icons.help_outline,
              onTap: () {
                // Navigate to help and support screen
              },
              context: context,
            ),
            buildListTile(
              title: 'About',
              subtitle: 'Learn more about the app',
              icon: Icons.info_outline,
              onTap: () {
                // Navigate to about screen
              },
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.blue, // Set the text color to blue
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildSwitchTile(
      {required String title,
        required bool value,
        required IconData icon,
        required Function(bool) onChanged,
        required BuildContext context}) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      secondary: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), // Grey outline
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.grey), // Set icon color to grey
      ),
      activeColor: Colors.blue, // Set active color to blue
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    );
  }

  Widget buildListTile(
      {required String title,
        required String subtitle,
        required IconData icon,
        required VoidCallback onTap,
        required BuildContext context}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), // Grey outline
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.grey), // Set icon color to grey
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    );
  }
}
