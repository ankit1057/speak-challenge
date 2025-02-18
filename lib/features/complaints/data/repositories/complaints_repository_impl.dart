import '../../domain/entities/complaint.dart';
import '../../domain/entities/complaint_type.dart';
import '../../domain/repositories/complaints_repository.dart';

/// Implementation of [ComplaintsRepository] with mock data
class ComplaintsRepositoryImpl implements ComplaintsRepository {
  // Mock complaints data
  final List<Complaint> _mockComplaints = [
    // Banking Complaints
    Complaint(
      id: '1',
      title: 'ATM Transaction Failed',
      description: 'Amount debited but cash not dispensed',
      category: 'Banking',
      organization: 'Global Trust Bank',
      status: 'Open',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      type: ComplaintType.complaint,
    ),
    Complaint(
      id: '2',
      title: 'Excellent Customer Service',
      description: 'The branch manager was very helpful in resolving my issue',
      category: 'Banking',
      organization: 'Secure Savings Bank',
      status: 'Closed',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      type: ComplaintType.compliment,
    ),
    
    // Telecom Complaints
    Complaint(
      id: '3',
      title: 'Poor Network Coverage',
      description: 'No signal in residential area',
      category: 'Telecom',
      organization: 'ConnectX Mobile',
      status: 'In Progress',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      type: ComplaintType.complaint,
    ),
    Complaint(
      id: '4',
      title: 'Billing System Improvement',
      description: 'Suggestion for making the billing portal more user-friendly',
      category: 'Telecom',
      organization: 'Global Communications',
      status: 'Under Review',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      type: ComplaintType.feedback,
    ),

    // Government Complaints
    Complaint(
      id: '5',
      title: 'Road Maintenance Required',
      description: 'Large potholes on Main Street need immediate attention',
      category: 'Government',
      organization: 'Department of Transportation',
      status: 'Open',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      type: ComplaintType.complaint,
    ),
    Complaint(
      id: '6',
      title: 'Efficient Passport Service',
      description: 'Got my passport renewed in record time',
      category: 'Government',
      organization: 'Department of State',
      status: 'Closed',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      type: ComplaintType.compliment,
    ),
  ];

  // Mock organizations data
  final List<Map<String, dynamic>> _organizations = [
    {
      'id': '1',
      'name': 'State Bank of India',
      'category': 'Banking',
      'icon': 'bank_icon.png',
    },
    {
      'id': '2',
      'name': 'Airtel',
      'category': 'Telecom',
      'icon': 'phone_icon.png',
    },
    {
      'id': '3',
      'name': 'Municipal Corporation',
      'category': 'Government',
      'icon': 'govt_icon.png',
    },
    // Add more organizations...
  ];

  @override
  Future<List<Complaint>> getComplaints() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    return _mockComplaints;
  }

  @override
  Future<Complaint> getComplaintById(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return _mockComplaints.firstWhere(
      (complaint) => complaint.id == id,
      orElse: () => throw Exception('Complaint not found'),
    );
  }

  @override
  Future<Complaint> createComplaint(Complaint complaint) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Create new complaint with generated ID
    final newComplaint = Complaint(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: complaint.title,
      description: complaint.description,
      category: complaint.category,
      organization: complaint.organization,
      status: 'Open',
      createdAt: DateTime.now(),
      attachments: complaint.attachments,
      type: complaint.type,
    );
    
    // Add to mock data
    _mockComplaints.insert(0, newComplaint);
    return newComplaint;
  }

  @override
  Future<void> updateComplaint(Complaint complaint) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    final index = _mockComplaints.indexWhere((c) => c.id == complaint.id);
    if (index != -1) {
      _mockComplaints[index] = complaint;
    }
  }

  /// Search organizations by name or category
  Future<List<Map<String, dynamic>>> searchOrganizations(String query) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (query.isEmpty) return _organizations;
    
    query = query.toLowerCase();
    return _organizations.where((org) {
      return org['name'].toLowerCase().contains(query) ||
             org['category'].toLowerCase().contains(query);
    }).toList();
  }

  /// Get organization details by ID
  Future<Map<String, dynamic>?> getOrganizationById(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    return _organizations.firstWhere(
      (org) => org['id'] == id,
      orElse: () => throw Exception('Organization not found'),
    );
  }
} 