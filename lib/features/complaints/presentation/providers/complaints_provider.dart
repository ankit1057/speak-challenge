import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../domain/entities/complaint.dart';
import '../../domain/services/complaint_service.dart';

/// Provider to manage complaints state throughout the app
class ComplaintsProvider with ChangeNotifier {
  final ComplaintService _complaintService;
  List<Complaint> _complaints = [];
  bool _isLoading = false;

  ComplaintsProvider(this._complaintService);

  List<Complaint> get complaints => _complaints;
  bool get isLoading => _isLoading;

  /// Fetch complaints from the service
  Future<void> fetchComplaints() async {
    _isLoading = true;
    notifyListeners();

    try {
      _complaints = await _complaintService.getUserComplaints();
    } catch (e) {
      debugPrint('Error fetching complaints: $e');
      _complaints = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh complaints list
  Future<void> refreshComplaints() async {
    await fetchComplaints();
  }

  /// Create a new complaint
  Future<void> createComplaint(Complaint complaint, {List<File>? attachments}) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _complaintService.createComplaint(
        title: complaint.title,
        description: complaint.description,
        category: complaint.category,
        organization: complaint.organization,
        type: complaint.type,
        attachments: attachments,
      );
      await refreshComplaints();
    } catch (e) {
      debugPrint('Error creating complaint: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 