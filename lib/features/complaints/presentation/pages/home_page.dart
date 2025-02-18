import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speakup/features/home/presentation/widgets/search_header.dart';
import '../../../../core/layouts/main_layout.dart';
import '../../../home/presentation/widgets/category_grid.dart';
import '../../../home/presentation/widgets/stats_card.dart';
import 'select_category_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectCategoryPage(),
            ),
          );
        },
        icon: const FaIcon(FontAwesomeIcons.plus),
        label: const Text('New Complaint'),
      ),
      child: Column(
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
    );
  }
} 