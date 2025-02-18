import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/status_update.dart';

class ComplaintTimeline extends StatelessWidget {
  final List<StatusUpdate> updates;

  const ComplaintTimeline({
    super.key,
    required this.updates,
  });

  @override
  Widget build(BuildContext context) {
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
              _buildTimelineColumn(context, update, isLast),
              Expanded(
                child: _buildUpdateCard(context, update),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimelineColumn(BuildContext context, StatusUpdate update, bool isLast) {
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _getStatusColor(update.status).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: FaIcon(
                _getStatusIcon(update.status),
                size: 12,
                color: _getStatusColor(update.status),
              ),
            ),
          ),
          if (!isLast)
            Expanded(
              child: Container(
                width: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.grey.shade300,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUpdateCard(BuildContext context, StatusUpdate update) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16, right: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  update.status,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: _getStatusColor(update.status),
                  ),
                ),
                Text(
                  DateFormat('MMM dd, yyyy hh:mm a').format(update.timestamp),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              update.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (update.updatedBy != null) ...[
              const SizedBox(height: 8),
              Text(
                'Updated by ${update.updatedBy}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
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

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return FontAwesomeIcons.folderOpen;
      case 'in progress':
        return FontAwesomeIcons.spinner;
      case 'under review':
        return FontAwesomeIcons.magnifyingGlass;
      case 'resolved':
        return FontAwesomeIcons.check;
      case 'closed':
        return FontAwesomeIcons.folderClosed;
      default:
        return FontAwesomeIcons.circle;
    }
  }
} 