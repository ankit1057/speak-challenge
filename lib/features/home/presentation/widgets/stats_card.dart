import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../complaints/presentation/providers/complaints_provider.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Statistics',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Consumer<ComplaintsProvider>(
              builder: (context, provider, child) {
                final complaints = provider.complaints;
                final today = DateTime.now();
                final todayComplaints = complaints.where((c) {
                  return c.createdAt.year == today.year &&
                         c.createdAt.month == today.month &&
                         c.createdAt.day == today.day;
                }).toList();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      context,
                      FontAwesomeIcons.fileCirclePlus,
                      todayComplaints.length.toString(),
                      'New',
                      Colors.blue,
                    ),
                    _buildStatItem(
                      context,
                      FontAwesomeIcons.spinner,
                      todayComplaints.where((c) => c.status == 'In Progress').length.toString(),
                      'In Progress',
                      Colors.orange,
                    ),
                    _buildStatItem(
                      context,
                      FontAwesomeIcons.check,
                      todayComplaints.where((c) => c.status == 'Resolved').length.toString(),
                      'Resolved',
                      Colors.green,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String count,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: FaIcon(
              icon,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          count,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
} 