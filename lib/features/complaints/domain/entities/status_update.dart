class StatusUpdate {
  final String status;
  final String description;
  final DateTime timestamp;
  final String? updatedBy;

  const StatusUpdate({
    required this.status,
    required this.description,
    required this.timestamp,
    this.updatedBy,
  });
} 