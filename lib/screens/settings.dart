import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:offline_ai/const/color.dart';

class SettingsScreen extends StatefulWidget {
  final Function toggleThemeMode;

  SettingsScreen({required this.toggleThemeMode});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 7, 6, 6)
            : const Color.fromARGB(255, 231, 227, 227),
        title: Row(
          children: [
            Icon(
              CupertinoIcons.settings,
              size: 40,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            const SizedBox(width: 10),
            const Text(
              'Settings',
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SettingsCategory(title: 'Push notifications'),
          SettingsTile(
            title: 'Notifications settings',
            icon: Icons.notifications,
          ),
          SettingsCategory(title: 'User'),
          SettingsTile(
            title: 'Not logged in',
            icon: Icons.person,
            trailingWidget: const ElevatedButton(
              onPressed: settingslogin,
              child: Text('LOG IN'),
            ),
          ),
          SettingsCategory(title: 'Theme'),
          SettingsTile(
            title: 'Dark mode',
            icon: Icons.brightness_2,
            trailingWidget: Switch(
              value: Theme.of(context).brightness ==
                  Brightness.dark, // Check if dark mode is enabled
              onChanged: (value) {
                widget.toggleThemeMode(); // Call the toggle function
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsCategory extends StatelessWidget {
  final String title;

  SettingsCategory({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.grey[600],
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailingWidget;

  SettingsTile({
    required this.title,
    required this.icon,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      trailing: trailingWidget,
    );
  }
}

void settingslogin() {
  Get.offAndToNamed("/login");
}
