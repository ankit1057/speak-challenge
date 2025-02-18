import '../entities/complaint.dart';

class StatusUpdate {
  final String status;
  final String description;
  final DateTime timestamp;
  final String? assignedTo;

  StatusUpdate({
    required this.status,
    required this.description,
    required this.timestamp,
    this.assignedTo,
  });
}

class StatusTrackingService {
  // Mock status updates
  final Map<String, List<StatusUpdate>> _statusUpdates = {};

  Future<List<StatusUpdate>> getStatusUpdates(String complaintId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (!_statusUpdates.containsKey(complaintId)) {
      // Create mock updates for new complaints
      _statusUpdates[complaintId] = [
        StatusUpdate(
          status: 'Open',
          description: 'Complaint received and registered in the system',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
        StatusUpdate(
          status: 'Under Review',
          description: 'Complaint is being reviewed by the concerned department',
          timestamp: DateTime.now().subtract(const Duration(hours: 12)),
          assignedTo: 'Customer Service Team',
        ),
      ];
    }

    return _statusUpdates[complaintId]!;
  }

  Future<void> addStatusUpdate(
    String complaintId,
    StatusUpdate update,
  ) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    if (!_statusUpdates.containsKey(complaintId)) {
      _statusUpdates[complaintId] = [];
    }

    _statusUpdates[complaintId]!.add(update);
  }

  String getStatusDescription(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return 'Your complaint has been registered and is awaiting initial review';
      case 'under review':
        return 'Your complaint is being reviewed by the concerned department';
      case 'in progress':
        return 'Action is being taken on your complaint';
      case 'resolved':
        return 'Your complaint has been resolved';
      case 'closed':
        return 'This complaint has been closed';
      default:
        return 'Status unknown';
    }
  }

  int getStatusProgress(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return 20;
      case 'under review':
        return 40;
      case 'in progress':
        return 60;
      case 'resolved':
        return 80;
      case 'closed':
        return 100;
      default:
        return 0;
    }
  }
} 