import 'package:flutter/material.dart';
import '../../domain/services/status_tracking_service.dart';
import 'package:intl/intl.dart';

class StatusTrackingWidget extends StatelessWidget {
  final String complaintId;
  final String currentStatus;
  final StatusTrackingService statusService;

  const StatusTrackingWidget({
    super.key,
    required this.complaintId,
    required this.currentStatus,
    required this.statusService,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StatusUpdate>>(
      future: statusService.getStatusUpdates(complaintId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No status updates available'));
        }

        final updates = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressIndicator(context),
            const SizedBox(height: 24),
            _buildStatusTimeline(context, updates),
          ],
        );
      },
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    final progress = statusService.getStatusProgress(currentStatus);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Status: $currentStatus',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          statusService.getStatusDescription(currentStatus),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(
          value: progress / 100,
          backgroundColor: Colors.grey[200],
          color: _getStatusColor(currentStatus),
        ),
      ],
    );
  }

  Widget _buildStatusTimeline(
    BuildContext context,
    List<StatusUpdate> updates,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: updates.length,
      itemBuilder: (context, index) {
        final update = updates[index];
        final isLast = index == updates.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _getStatusColor(update.status),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: Colors.grey[300],
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      update.status,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      update.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (update.assignedTo != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Assigned to: ${update.assignedTo}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM dd, yyyy HH:mm').format(update.timestamp),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    if (!isLast) const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.blue;
      case 'under review':
        return Colors.orange;
      case 'in progress':
        return Colors.amber;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
} 