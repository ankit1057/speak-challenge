import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../core/layouts/main_layout.dart';
import '../../../complaints/presentation/providers/complaints_provider.dart';
import '../widgets/search_header.dart';
import '../widgets/stats_card.dart';
import '../widgets/category_grid.dart';
import '../widgets/sidebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const Sidebar(),
      body: RefreshIndicator(
        onRefresh: () => context.read<ComplaintsProvider>().refreshComplaints(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SearchHeader(),
            const SizedBox(height: 24),
            const StatsCard(),
            const SizedBox(height: 24),
            Text(
              'Categories',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const CategoryGrid(),
          ],
        ),
      ),
    );
  }
} 