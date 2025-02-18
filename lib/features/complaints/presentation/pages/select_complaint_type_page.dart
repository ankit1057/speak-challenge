import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/layouts/main_layout.dart';
import '../../data/dummy_data/organizations.dart';
import '../../domain/entities/complaint_type.dart';
import 'create_complaint_page.dart';

class SelectComplaintTypePage extends StatelessWidget {
  final Organization organization;

  const SelectComplaintTypePage({
    super.key,
    required this.organization,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Select Type',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOrganizationHeader(context),
          const SizedBox(height: 24),
          ...ComplaintType.values.map((type) => _buildTypeCard(
                context,
                type,
                () => _onTypeSelected(context, type),
              )),
        ],
      ),
    );
  }

  Widget _buildOrganizationHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Organization',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              organization.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (organization.address != null) ...[
              const SizedBox(height: 4),
              Text(
                organization.address!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTypeCard(
    BuildContext context,
    ComplaintType type,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: type.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: FaIcon(
                    type.icon,
                    color: type.color,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type.displayName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      type.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const FaIcon(
                FontAwesomeIcons.angleRight,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTypeSelected(BuildContext context, ComplaintType type) {
    Navigator.pushNamed(
      context,
      '/create-complaint',
      arguments: {
        'organization': organization,
        'complaintType': type,
      },
    );
  }
} 