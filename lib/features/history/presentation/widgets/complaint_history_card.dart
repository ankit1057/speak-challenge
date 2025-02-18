import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplaintHistoryCard extends StatelessWidget {
  final int complaintId;
  final String status;
  final DateTime date;

  const ComplaintHistoryCard({
    super.key,
    required this.complaintId,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final isOpen = status == 'Open';
    final statusColor = isOpen ? Colors.green : Colors.grey;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          'Complaint #$complaintId',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Filed on: ${DateFormat('MMM dd, yyyy').format(date)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Navigate to complaint details
        },
      ),
    );
  }
} 