import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

/// Service to handle navigation throughout the app
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigate to a route and remove all previous routes
  Future<void> navigateToAndRemoveUntil(String routeName, {Object? arguments}) async {
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Navigate to a route
  Future<void> navigateTo(String routeName, {Object? arguments}) async {
    await navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate back
  void goBack() {
    navigatorKey.currentState?.pop();
  }

  /// Check if can go back
  bool canGoBack() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  /// Handle back navigation with confirmation if needed
  Future<bool> handleBackNavigation(BuildContext context) async {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    
    // Show confirmation dialog for unsaved changes
    if (currentRoute == AppRoutes.createComplaint) {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Discard changes?'),
          content: const Text('You have unsaved changes. Are you sure you want to leave?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Discard'),
            ),
          ],
        ),
      );
      return shouldPop ?? false;
    }

    return AppRoutes.onWillPop(context);
  }
} 