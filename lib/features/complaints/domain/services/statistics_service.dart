import '../entities/complaint.dart';

class ComplaintStatistics {
  final int totalComplaints;
  final int openComplaints;
  final int resolvedComplaints;
  final Map<String, int> complaintsByCategory;
  final Map<String, int> complaintsByStatus;
  final List<DailyStatistic> dailyStatistics;

  ComplaintStatistics({
    required this.totalComplaints,
    required this.openComplaints,
    required this.resolvedComplaints,
    required this.complaintsByCategory,
    required this.complaintsByStatus,
    required this.dailyStatistics,
  });
}

class DailyStatistic {
  final DateTime date;
  final int count;

  DailyStatistic({
    required this.date,
    required this.count,
  });
}

class StatisticsService {
  ComplaintStatistics calculateStatistics(List<Complaint> complaints) {
    final complaintsByCategory = <String, int>{};
    final complaintsByStatus = <String, int>{};
    final dailyStats = <DateTime, int>{};

    int openCount = 0;
    int resolvedCount = 0;

    for (final complaint in complaints) {
      // Category stats
      complaintsByCategory.update(
        complaint.category,
        (value) => value + 1,
        ifAbsent: () => 1,
      );

      // Status stats
      complaintsByStatus.update(
        complaint.status,
        (value) => value + 1,
        ifAbsent: () => 1,
      );

      // Count by status
      if (complaint.status == 'Open') {
        openCount++;
      } else if (complaint.status == 'Resolved') {
        resolvedCount++;
      }

      // Daily stats
      final date = DateTime(
        complaint.createdAt.year,
        complaint.createdAt.month,
        complaint.createdAt.day,
      );
      dailyStats.update(
        date,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    // Convert daily stats to list and sort
    final dailyStatistics = dailyStats.entries
        .map((e) => DailyStatistic(date: e.key, count: e.value))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return ComplaintStatistics(
      totalComplaints: complaints.length,
      openComplaints: openCount,
      resolvedComplaints: resolvedCount,
      complaintsByCategory: complaintsByCategory,
      complaintsByStatus: complaintsByStatus,
      dailyStatistics: dailyStatistics,
    );
  }
} 