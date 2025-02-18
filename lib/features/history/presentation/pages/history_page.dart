import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/complaint_history_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) => ComplaintHistoryCard(
          complaintId: 1000 + index,
          status: index % 2 == 0 ? 'Open' : 'Closed',
          date: DateTime.now().subtract(Duration(days: index)),
        ),
      ),
    );
  }
} 