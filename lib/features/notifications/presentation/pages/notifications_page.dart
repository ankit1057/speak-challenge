import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/layouts/main_layout.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Notifications',
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10, // Replace with actual notifications count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: FaIcon(
                  _getNotificationIcon(index),
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
              ),
              title: Text(_getNotificationTitle(index)),
              subtitle: Text(_getNotificationBody(index)),
              trailing: Text(
                '2h ago', // Replace with actual time
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getNotificationIcon(int index) {
    switch (index % 4) {
      case 0:
        return FontAwesomeIcons.bell;
      case 1:
        return FontAwesomeIcons.check;
      case 2:
        return FontAwesomeIcons.comment;
      case 3:
        return FontAwesomeIcons.exclamation;
      default:
        return FontAwesomeIcons.bell;
    }
  }

  String _getNotificationTitle(int index) {
    switch (index % 4) {
      case 0:
        return 'New Update';
      case 1:
        return 'Complaint Resolved';
      case 2:
        return 'New Response';
      case 3:
        return 'Status Change';
      default:
        return 'Notification';
    }
  }

  String _getNotificationBody(int index) {
    switch (index % 4) {
      case 0:
        return 'Your complaint has been updated with new information.';
      case 1:
        return 'Your complaint #1234 has been resolved successfully.';
      case 2:
        return 'The organization has responded to your complaint.';
      case 3:
        return 'The status of your complaint has been changed to "In Progress".';
      default:
        return 'New notification received.';
    }
  }
} 