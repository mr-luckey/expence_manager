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
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildSectionHeader(context, 'Preferences'),
            buildSwitchTile(
              context,
              title: 'Enable Notifications',
              value: _notificationsEnabled,
              icon: Icons.notifications_active_outlined,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                _saveSettings();
              },
            ),
            buildSwitchTile(
              context,
              title: 'Enable Dark Mode',
              value: _darkModeEnabled,
              icon: Icons.dark_mode_outlined,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
                _saveSettings();
              },
            ),
            SizedBox(height: 20),
            buildSectionHeader(context, 'Account'),
            buildListTile(
              context,
              title: 'Account Settings',
              subtitle: 'Manage your account settings',
              icon: Icons.account_circle_outlined,
              onTap: () {
                // Navigate to account settings screen
              },
            ),
            buildListTile(
              context,
              title: 'Privacy',
              subtitle: 'Manage your privacy settings',
              icon: Icons.privacy_tip_outlined,
              onTap: () {
                // Navigate to privacy settings screen
              },
            ),
            SizedBox(height: 20),
            buildSectionHeader(context, 'Support'),
            buildListTile(
              context,
              title: 'Help & Support',
              subtitle: 'Get help and support',
              icon: Icons.help_outline,
              onTap: () {
                // Navigate to help and support screen
              },
            ),
            buildListTile(
              context,
              title: 'About',
              subtitle: 'Learn more about the app',
              icon: Icons.info_outline,
              onTap: () {
                // Navigate to about screen
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6?.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildSwitchTile(BuildContext context,
      {required String title, required bool value, required IconData icon, required Function(bool) onChanged}) {
    return SwitchListTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyText1),
      value: value,
      onChanged: onChanged,
      secondary: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      activeColor: Theme.of(context).primaryColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    );
  }

  Widget buildListTile(BuildContext context,
      {required String title, required String subtitle, required IconData icon, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyText1),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyText2),
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    );
  }
}
