import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../core/layouts/main_layout.dart';
import '../providers/complaints_provider.dart';
import '../widgets/stat_card.dart';
import '../widgets/category_chart.dart';
import '../widgets/status_chart.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Statistics',
      child: RefreshIndicator(
        onRefresh: () => context.read<ComplaintsProvider>().refreshComplaints(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Consumer<ComplaintsProvider>(
              builder: (context, provider, child) {
                final complaints = provider.complaints;
                final totalComplaints = complaints.length;
                final openComplaints = complaints.where((c) => c.status == 'Open').length;
                final resolvedComplaints = complaints.where((c) => c.status == 'Resolved').length;
                final resolutionRate = totalComplaints > 0 
                    ? (resolvedComplaints / totalComplaints * 100).toStringAsFixed(1)
                    : 'N/A';

                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            icon: FontAwesomeIcons.fileLines,
                            title: 'Total Complaints',
                            value: totalComplaints.toString(),
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            icon: FontAwesomeIcons.folderOpen,
                            title: 'Open Complaints',
                            value: openComplaints.toString(),
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            icon: FontAwesomeIcons.check,
                            title: 'Resolved',
                            value: resolvedComplaints.toString(),
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            icon: FontAwesomeIcons.chartLine,
                            title: 'Resolution Rate',
                            value: '$resolutionRate%',
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Complaints by Category',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CategoryChart(complaints: complaints),
                    const SizedBox(height: 24),
                    const Text(
                      'Status Distribution',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    StatusChart(complaints: complaints),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 