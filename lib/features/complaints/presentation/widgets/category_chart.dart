import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/complaint.dart';

class CategoryChart extends StatelessWidget {
  final List<Complaint> complaints;

  const CategoryChart({
    super.key,
    required this.complaints,
  });

  @override
  Widget build(BuildContext context) {
    final categoryData = _getCategoryData();

    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: categoryData.fold(0, (max, item) => 
                item.count > max ? item.count : max).toDouble(),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= categoryData.length) return const Text('');
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          categoryData[value.toInt()].category,
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 12),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              barGroups: categoryData.asMap().entries.map((entry) {
                return BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.count.toDouble(),
                      color: entry.value.color,
                      width: 22,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  List<CategoryData> _getCategoryData() {
    final Map<String, int> categoryCounts = {};
    for (final complaint in complaints) {
      categoryCounts[complaint.category] = 
          (categoryCounts[complaint.category] ?? 0) + 1;
    }

    return [
      CategoryData('Banking', categoryCounts['Banking'] ?? 0, Colors.blue),
      CategoryData('Government', categoryCounts['Government'] ?? 0, Colors.purple),
      CategoryData('Telecom', categoryCounts['Telecom'] ?? 0, Colors.orange),
    ];
  }
}

class CategoryData {
  final String category;
  final int count;
  final Color color;

  CategoryData(this.category, this.count, this.color);
} 