import '../entities/complaint.dart';

abstract class ComplaintsRepository {
  Future<List<Complaint>> getComplaints();
  Future<Complaint> getComplaintById(String id);
  Future<Complaint> createComplaint(Complaint complaint);
  Future<void> updateComplaint(Complaint complaint);
} 