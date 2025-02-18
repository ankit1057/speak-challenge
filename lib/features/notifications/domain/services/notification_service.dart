import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // In-memory storage for notifications
  final List<Notification> _notifications = [];

  Future<void> initialize() async {
    // Simulate initialization
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    // Store notification
    _notifications.add(
      Notification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        body: body,
        timestamp: DateTime.now(),
        payload: payload,
      ),
    );
  }

  List<Notification> getNotifications() {
    return List.from(_notifications.reversed);
  }

  void clearNotifications() {
    _notifications.clear();
  }
}

class Notification {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final String? payload;

  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.payload,
  });
} 