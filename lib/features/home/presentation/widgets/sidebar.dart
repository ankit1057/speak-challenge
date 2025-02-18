import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'SpeakUp',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.history),
            title: const Text('History'),
            onTap: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.user),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.cog),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.signOutAlt),
            title: const Text('Logout'),
            onTap: () {
              // Implement logout functionality
            },
          ),
        ],
      ),
    );
  }
} 