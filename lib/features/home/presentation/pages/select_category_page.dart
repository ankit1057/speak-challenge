import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/layouts/main_layout.dart';

class SelectCategoryPage extends StatelessWidget {
  const SelectCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Select Category',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCategoryCard(
            context,
            'Banking',
            'Report issues with banks and financial institutions',
            FontAwesomeIcons.buildingColumns,
            Colors.blue,
          ),
          _buildCategoryCard(
            context,
            'Government',
            'Submit feedback about government services',
            FontAwesomeIcons.landmark,
            Colors.purple,
          ),
          _buildCategoryCard(
            context,
            'Telecom',
            'Report telecom and internet service issues',
            FontAwesomeIcons.satellite,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/select-organization',
            arguments: title,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: FaIcon(
                    icon,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
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
} 