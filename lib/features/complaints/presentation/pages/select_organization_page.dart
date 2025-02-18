import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/layouts/main_layout.dart';
import '../../../../core/widgets/search_bar_widget.dart';
import '../../data/dummy_data/organizations.dart';
import '../widgets/organization_card.dart';
import 'select_complaint_type_page.dart';

class SelectOrganizationPage extends StatefulWidget {
  final String category;

  const SelectOrganizationPage({
    super.key,
    required this.category,
  });

  @override
  State<SelectOrganizationPage> createState() => _SelectOrganizationPageState();
}

class _SelectOrganizationPageState extends State<SelectOrganizationPage> {
  final _searchController = TextEditingController();
  List<Organization> _filteredOrganizations = [];

  @override
  void initState() {
    super.initState();
    _filteredOrganizations = organizations
        .where((org) => org.category == widget.category)
        .toList();
  }

  void _filterOrganizations(String query) {
    setState(() {
      _filteredOrganizations = organizations
          .where((org) =>
              org.category == widget.category &&
              org.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Select Organization',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBarWidget(
              controller: _searchController,
              hintText: 'Search organizations...',
              onChanged: _filterOrganizations,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredOrganizations.length,
              itemBuilder: (context, index) {
                final organization = _filteredOrganizations[index];
                return OrganizationCard(
                  organization: organization,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectComplaintTypePage(
                          organization: organization,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 