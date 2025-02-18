import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/complaints/presentation/pages/statistics_page.dart';
import '../../features/complaints/presentation/pages/search_page.dart';
import '../../features/complaints/presentation/pages/complaint_details_page.dart';
import '../../features/complaints/presentation/pages/create_complaint_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/support/presentation/pages/support_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/complaints/domain/entities/complaint.dart';
import '../../features/complaints/presentation/providers/complaints_provider.dart';
import '../../features/complaints/data/dummy_data/organizations.dart';
import '../../features/complaints/domain/entities/complaint_type.dart';
import '../../features/complaints/presentation/pages/select_category_page.dart';
import '../../features/complaints/presentation/pages/select_organization_page.dart';

/// Handles all app routes and their respective builders
class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String history = '/history';
  static const String statistics = '/statistics';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String support = '/support';
  static const String search = '/search';
  static const String complaintDetails = '/complaint-details';
  static const String createComplaint = '/create-complaint';
  static const String selectCategory = '/select-category';
  static const String selectOrganization = '/select-organization';

  /// Map of all routes to their respective builders
  static Map<String, Widget Function(BuildContext)> get routes => {
    initial: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    history: (context) => const HistoryPage(),
    statistics: (context) => const StatisticsPage(),
    profile: (context) => const ProfilePage(),
    settings: (context) => const SettingsPage(),
    notifications: (context) => const NotificationsPage(),
    support: (context) => const SupportPage(),
    search: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      return SearchPage(
        initialCategory: args?['category'] as String?,
        initialSearch: args?['initialSearch'] as bool? ?? false,
      );
    },
    complaintDetails: (context) {
      final complaint = ModalRoute.of(context)?.settings.arguments as Complaint;
      return ComplaintDetailsPage(complaint: complaint);
    },
    createComplaint: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      return CreateComplaintPage(
        organization: args['organization'] as Organization,
        complaintType: args['complaintType'] as ComplaintType,
      );
    },
    selectCategory: (context) => const SelectCategoryPage(),
    selectOrganization: (context) {
      final category = ModalRoute.of(context)?.settings.arguments as String;
      return SelectOrganizationPage(category: category);
    },
  };

  /// Handle back navigation
  static Future<bool> onWillPop(BuildContext context) async {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    
    // Don't allow back navigation from home screen
    if (currentRoute == initial) {
      return false;
    }

    // Handle special cases
    if (currentRoute == complaintDetails) {
      // Refresh complaints list when returning from details
      await context.read<ComplaintsProvider>().refreshComplaints();
    }

    return true;
  }
} 