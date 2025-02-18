import 'package:flutter/material.dart';
import '../../../../core/layouts/main_layout.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../domain/entities/complaint.dart';
import '../../domain/services/status_tracking_service.dart';
import 'package:provider/provider.dart';
import '../widgets/status_tracking_widget.dart';
import 'package:intl/intl.dart';

class ComplaintDetailsPage extends StatelessWidget {
  final Complaint complaint;

  const ComplaintDetailsPage({
    super.key,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Complaint Details',
      child: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        web: _buildWebLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusCard(context),
          const SizedBox(height: 24),
          _buildDetailsSection(context),
          if (complaint.attachments != null && complaint.attachments!.isNotEmpty) ...[
            const SizedBox(height: 24),
            _buildAttachmentsSection(context),
          ],
          const SizedBox(height: 24),
          _buildTimelineSection(context),
          if (complaint.status != 'Closed') ...[
            const SizedBox(height: 24),
            StatusTrackingWidget(
              complaintId: complaint.id,
              currentStatus: complaint.status,
              statusService: context.read<StatusTrackingService>(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusCard(context),
                const SizedBox(height: 24),
                _buildDetailsSection(context),
                if (complaint.attachments != null && complaint.attachments!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildAttachmentsSection(context),
                ],
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTimelineSection(context),
                if (complaint.status != 'Closed') ...[
                  const SizedBox(height: 24),
                  StatusTrackingWidget(
                    complaintId: complaint.id,
                    currentStatus: complaint.status,
                    statusService: context.read<StatusTrackingService>(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusCard(context),
                const SizedBox(height: 24),
                _buildDetailsSection(context),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (complaint.attachments != null && complaint.attachments!.isNotEmpty)
                  _buildAttachmentsSection(context),
                const SizedBox(height: 24),
                _buildTimelineSection(context),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: complaint.status != 'Closed'
                ? StatusTrackingWidget(
                    complaintId: complaint.id,
                    currentStatus: complaint.status,
                    statusService: context.read<StatusTrackingService>(),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: complaint.status == 'Open' ? Colors.green : Colors.grey,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status: ${complaint.status}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Complaint ID: ${complaint.id}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Organization', complaint.organization),
            _buildDetailRow('Category', complaint.category),
            _buildDetailRow('Title', complaint.title),
            _buildDetailRow('Description', complaint.description),
            _buildDetailRow(
              'Created',
              DateFormat('MMM dd, yyyy HH:mm').format(complaint.createdAt),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attachments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: complaint.attachments!.map((url) {
                return _buildAttachmentThumbnail(url);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentThumbnail(String url) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.error));
          },
        ),
      ),
    );
  }

  Widget _buildTimelineSection(BuildContext context) {
    final events = [
      {
        'title': 'Complaint Created',
        'description': 'Your complaint has been registered in the system',
        'date': complaint.createdAt,
      },
      {
        'title': 'Under Review',
        'description': 'Complaint is being reviewed by our team',
        'date': complaint.createdAt.add(const Duration(hours: 2)),
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Timeline',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  leading: const Icon(Icons.circle, size: 12),
                  title: Text(event['title'] as String),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event['description'] as String),
                      Text(
                        DateFormat('MMM dd, yyyy HH:mm')
                            .format(event['date'] as DateTime),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 