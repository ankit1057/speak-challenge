import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/complaint.dart';

class StatusChart extends StatelessWidget {
  final List<Complaint> complaints;

  const StatusChart({
    super.key,
    required this.complaints,
  });

  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusData();
    final total = statusData.fold(0, (sum, item) => sum + item.count);

    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: statusData.map((data) {
                    final percentage = total > 0 
                        ? (data.count / total * 100).toStringAsFixed(1)
                        : '0.0';
                    return PieChartSectionData(
                      color: data.color,
                      value: data.count.toDouble(),
                      title: '$percentage%',
                      radius: 100,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: statusData.map((data) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: data.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${data.status} (${data.count})',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<StatusData> _getStatusData() {
    final Map<String, int> statusCounts = {};
    for (final complaint in complaints) {
      statusCounts[complaint.status] = 
          (statusCounts[complaint.status] ?? 0) + 1;
    }

    return [
      StatusData('Open', statusCounts['Open'] ?? 0, Colors.blue),
      StatusData('In Progress', statusCounts['In Progress'] ?? 0, Colors.orange),
      StatusData('Under Review', statusCounts['Under Review'] ?? 0, Colors.purple),
      StatusData('Resolved', statusCounts['Resolved'] ?? 0, Colors.green),
      StatusData('Closed', statusCounts['Closed'] ?? 0, Colors.grey),
    ];
  }
}

class StatusData {
  final String status;
  final int count;
  final Color color;

  StatusData(this.status, this.count, this.color);
} 