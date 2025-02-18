import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../core/layouts/main_layout.dart';
import '../../domain/entities/complaint.dart';
import '../../domain/entities/complaint_type.dart';
import '../providers/complaints_provider.dart';
import '../widgets/complaint_card.dart';

// Move constants outside the class
const List<String> _kStatuses = [
  'Open',
  'In Progress',
  'Under Review',
  'Resolved',
  'Closed',
];

const List<String> _kCategories = [
  'Banking',
  'Government',
  'Telecom',
];

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ComplaintType? _selectedType;
  String? _selectedStatus;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadComplaints();
  }

  Future<void> _loadComplaints() async {
    await context.read<ComplaintsProvider>().fetchComplaints();
  }

  List<Complaint> _filterComplaints(List<Complaint> complaints) {
    return complaints.where((complaint) {
      if (_selectedType != null && complaint.type != _selectedType) {
        return false;
      }
      if (_selectedStatus != null && complaint.status != _selectedStatus) {
        return false;
      }
      if (_selectedCategory != null && complaint.category != _selectedCategory) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'History',
      child: Column(
        children: [
          _buildFilters(context),
          Expanded(
            child: Consumer<ComplaintsProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final filteredComplaints = _filterComplaints(provider.complaints);

                if (filteredComplaints.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.boxArchive,
                          size: 48,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No complaints found',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _loadComplaints,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredComplaints.length,
                    itemBuilder: (context, index) {
                      return ComplaintCard(
                        complaint: filteredComplaints[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTypeFilter(context),
                  const SizedBox(width: 16),
                  _buildStatusFilter(context),
                  const SizedBox(width: 16),
                  _buildCategoryFilter(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeFilter(BuildContext context) {
    return DropdownButton<ComplaintType>(
      value: _selectedType,
      hint: const Text('Type'),
      items: [
        const DropdownMenuItem(
          value: null,
          child: Text('All Types'),
        ),
        ...ComplaintType.values.map((type) {
          return DropdownMenuItem(
            value: type,
            child: Text(type.displayName),
          );
        }),
      ],
      onChanged: (value) {
        setState(() => _selectedType = value);
      },
    );
  }

  Widget _buildStatusFilter(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedStatus,
      hint: const Text('Status'),
      items: [
        const DropdownMenuItem(
          value: null,
          child: Text('All Statuses'),
        ),
        ..._kStatuses.map((status) {
          return DropdownMenuItem(
            value: status,
            child: Text(status),
          );
        }),
      ],
      onChanged: (value) {
        setState(() => _selectedStatus = value);
      },
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedCategory,
      hint: const Text('Category'),
      items: [
        const DropdownMenuItem(
          value: null,
          child: Text('All Categories'),
        ),
        ..._kCategories.map((category) {
          return DropdownMenuItem(
            value: category,
            child: Text(category),
          );
        }),
      ],
      onChanged: (value) {
        setState(() => _selectedCategory = value);
      },
    );
  }
} 