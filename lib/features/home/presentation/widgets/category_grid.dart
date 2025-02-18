import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'category_card.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        CategoryCard(
          icon: FontAwesomeIcons.buildingColumns,
          title: 'Banking',
          description: 'Financial services and banks',
          color: Colors.blue,
          onTap: () => _onCategoryTap(context, 'Banking'),
        ),
        CategoryCard(
          icon: FontAwesomeIcons.landmark,
          title: 'Government',
          description: 'Public services and departments',
          color: Colors.purple,
          onTap: () => _onCategoryTap(context, 'Government'),
        ),
        CategoryCard(
          icon: FontAwesomeIcons.satellite,
          title: 'Telecom',
          description: 'Mobile and internet services',
          color: Colors.orange,
          onTap: () => _onCategoryTap(context, 'Telecom'),
        ),
      ],
    );
  }

  void _onCategoryTap(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      '/select-organization',
      arguments: category,
    );
  }
} 