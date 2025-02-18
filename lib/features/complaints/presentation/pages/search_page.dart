import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../core/layouts/main_layout.dart';
import '../../../../core/widgets/search_bar_widget.dart';
import '../providers/search_provider.dart';
import '../widgets/complaint_card.dart';

class SearchPage extends StatefulWidget {
  final String? initialCategory;
  final bool initialSearch;

  const SearchPage({
    super.key,
    this.initialCategory,
    this.initialSearch = false,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    // Set initial category if provided
    if (widget.initialCategory != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<SearchProvider>().setFilters(
          category: widget.initialCategory,
        );
        if (widget.initialSearch) {
          context.read<SearchProvider>().search('');
        }
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Search',
      actions: [
        IconButton(
          icon: FaIcon(
            _showFilters 
                ? FontAwesomeIcons.filterCircleXmark
                : FontAwesomeIcons.filter,
            size: 20,
          ),
          onPressed: () {
            setState(() => _showFilters = !_showFilters);
          },
        ),
      ],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBarWidget(
              controller: _searchController,
              hintText: 'Search complaints...',
              onChanged: (query) {
                context.read<SearchProvider>().search(query);
              },
            ),
          ),
          if (_showFilters) _buildFilters(context),
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.searchResults.isEmpty) {
                  if (provider.query.isEmpty) {
                    return const Center(
                      child: Text('Enter a search term to begin'),
                    );
                  }
                  return const Center(
                    child: Text('No results found'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.searchResults.length,
                  itemBuilder: (context, index) {
                    final complaint = provider.searchResults[index];
                    return ComplaintCard(complaint: complaint);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, provider, child) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
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
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildDropdownFilter(
                      context,
                      'Category',
                      ['Banking', 'Government', 'Telecom'],
                      provider.selectedCategory,
                      (value) => provider.setFilters(category: value),
                    ),
                    _buildDropdownFilter(
                      context,
                      'Status',
                      ['Open', 'In Progress', 'Resolved', 'Closed'],
                      provider.selectedStatus,
                      (value) => provider.setFilters(status: value),
                    ),
                    _buildDateRangeFilter(context, provider),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        provider.clearFilters();
                      },
                      child: const Text('Clear Filters'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdownFilter(
    BuildContext context,
    String label,
    List<String> items,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedValue,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeFilter(
    BuildContext context,
    SearchProvider provider,
  ) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Date Range'),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final dateRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                initialDateRange: provider.startDate != null && provider.endDate != null
                    ? DateTimeRange(
                        start: provider.startDate!,
                        end: provider.endDate!,
                      )
                    : null,
              );

              if (dateRange != null) {
                provider.setFilters(
                  startDate: dateRange.start,
                  endDate: dateRange.end,
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.calendar,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      provider.startDate != null && provider.endDate != null
                          ? '${_formatDate(provider.startDate!)} - ${_formatDate(provider.endDate!)}'
                          : 'Select dates',
                      style: TextStyle(
                        color: provider.startDate != null
                            ? null
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
} 