import 'complaint_type.dart';
import 'package:flutter/material.dart';
import 'status_update.dart';

/// Represents a complaint in the system
class Complaint {
  final String id;
  final String title;
  final String description;
  final String category;
  final String organization;
  final String status;
  final DateTime createdAt;
  final List<String>? attachments;
  final ComplaintType type;
  final List<StatusUpdate> statusUpdates;

  const Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.organization,
    required this.status,
    required this.createdAt,
    required this.type,
    this.attachments,
    this.statusUpdates = const [],
  });

  Complaint copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? organization,
    String? status,
    DateTime? createdAt,
    List<String>? attachments,
    ComplaintType? type,
    List<StatusUpdate>? statusUpdates,
  }) {
    return Complaint(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      organization: organization ?? this.organization,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      attachments: attachments ?? this.attachments,
      type: type ?? this.type,
      statusUpdates: statusUpdates ?? this.statusUpdates,
    );
  }

  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.blue;
      case 'in progress':
        return Colors.orange;
      case 'under review':
        return Colors.purple;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
} 