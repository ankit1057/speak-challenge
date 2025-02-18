import 'package:flutter/foundation.dart';
import '../../domain/services/complaint_service.dart';
import '../../domain/entities/complaint.dart';

class SearchProvider with ChangeNotifier {
  final ComplaintService _complaintService;
  String _query = '';
  List<Complaint> _searchResults = [];
  bool _isLoading = false;
  String? _selectedCategory;
  String? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;

  SearchProvider(this._complaintService);

  String get query => _query;
  List<Complaint> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String? get selectedCategory => _selectedCategory;
  String? get selectedStatus => _selectedStatus;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  Future<void> search(String query) async {
    _query = query;
    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = await _complaintService.searchComplaints(
        query: query,
        category: _selectedCategory,
        status: _selectedStatus,
        startDate: _startDate,
        endDate: _endDate,
      );
    } catch (e) {
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setFilters({
    String? category,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    _selectedCategory = category;
    _selectedStatus = status;
    _startDate = startDate;
    _endDate = endDate;
    if (_query.isNotEmpty) {
      search(_query);
    }
  }

  void clearFilters() {
    _selectedCategory = null;
    _selectedStatus = null;
    _startDate = null;
    _endDate = null;
    if (_query.isNotEmpty) {
      search(_query);
    }
  }
} 