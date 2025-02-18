import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/responsive_layout.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/complaints/presentation/pages/statistics_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../core/widgets/search_bar_widget.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const MainLayout({
    super.key,
    required this.child,
    required this.title,
    this.actions,
    this.floatingActionButton,
  });

  void _handleNavigation(BuildContext context, String route) {
    // Close drawer if open on mobile
    if (ResponsiveLayout.isMobile(context)) {
      Navigator.pop(context);
    }
    
    // Navigate to the selected route
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveLayout.isMobile(context)
          ? AppBar(
              title: Text(title),
              actions: actions,
            )
          : null,
      drawer: ResponsiveLayout.isMobile(context)
          ? _buildDrawer(context)
          : null,
      body: ResponsiveLayout(
        mobile: child,
        tablet: _TabletLayout(
          title: title,
          actions: actions,
          child: child,
          onNavigate: (route) => _handleNavigation(context, route),
        ),
        web: _WebLayout(
          title: title,
          actions: actions,
          child: child,
          onNavigate: (route) => _handleNavigation(context, route),
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: FaIcon(FontAwesomeIcons.user),
                ),
                const SizedBox(height: 16),
                Text(
                  'Speak Up',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          _NavItem(
            icon: FontAwesomeIcons.house,
            label: 'Home',
            isSelected: currentRoute == '/',
            onTap: () => _handleNavigation(context, '/'),
          ),
          _NavItem(
            icon: FontAwesomeIcons.clockRotateLeft,
            label: 'History',
            isSelected: currentRoute == '/history',
            onTap: () => _handleNavigation(context, '/history'),
          ),
          _NavItem(
            icon: FontAwesomeIcons.chartLine,
            label: 'Statistics',
            isSelected: currentRoute == '/statistics',
            onTap: () => _handleNavigation(context, '/statistics'),
          ),
          _NavItem(
            icon: FontAwesomeIcons.user,
            label: 'Profile',
            isSelected: currentRoute == '/profile',
            onTap: () => _handleNavigation(context, '/profile'),
          ),
          _NavItem(
            icon: FontAwesomeIcons.gear,
            label: 'Settings',
            isSelected: currentRoute == '/settings',
            onTap: () => _handleNavigation(context, '/settings'),
          ),
          const Divider(),
          _NavItem(
            icon: FontAwesomeIcons.bell,
            label: 'Notifications',
            badge: '3',
            onTap: () => _handleNavigation(context, '/notifications'),
          ),
          _NavItem(
            icon: FontAwesomeIcons.circleQuestion,
            label: 'Help & Support',
            onTap: () => _handleNavigation(context, '/support'),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final String? badge;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        icon,
        color: isSelected ? Theme.of(context).primaryColor : null,
        size: 20,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Theme.of(context).primaryColor : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            )
          : null,
      selected: isSelected,
      onTap: onTap,
    );
  }
}

class _TabletLayout extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget child;
  final Function(String) onNavigate;

  const _TabletLayout({
    required this.title,
    this.actions,
    required this.child,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          extended: true,
          destinations: const [
            NavigationRailDestination(
              icon: FaIcon(FontAwesomeIcons.house, size: 20),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: FaIcon(FontAwesomeIcons.clockRotateLeft, size: 20),
              label: Text('History'),
            ),
            NavigationRailDestination(
              icon: FaIcon(FontAwesomeIcons.chartLine, size: 20),
              label: Text('Statistics'),
            ),
            NavigationRailDestination(
              icon: FaIcon(FontAwesomeIcons.user, size: 20),
              label: Text('Profile'),
            ),
            NavigationRailDestination(
              icon: FaIcon(FontAwesomeIcons.gear, size: 20),
              label: Text('Settings'),
            ),
          ],
          selectedIndex: _getSelectedIndex(ModalRoute.of(context)?.settings.name ?? '/'),
          onDestinationSelected: (index) {
            onNavigate(_getRouteForIndex(index));
          },
        ),
        Expanded(
          child: Column(
            children: [
              AppBar(
                title: Text(title),
                actions: actions,
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ],
    );
  }

  String _getRouteForIndex(int index) {
    switch (index) {
      case 0:
        return '/';
      case 1:
        return '/history';
      case 2:
        return '/statistics';
      case 3:
        return '/profile';
      case 4:
        return '/settings';
      default:
        return '/';
    }
  }

  int _getSelectedIndex(String currentRoute) {
    switch (currentRoute) {
      case '/':
        return 0;
      case '/history':
        return 1;
      case '/statistics':
        return 2;
      case '/profile':
        return 3;
      case '/settings':
        return 4;
      default:
        return 0;
    }
  }
}

class _WebLayout extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget child;
  final Function(String) onNavigate;

  const _WebLayout({
    required this.title,
    this.actions,
    required this.child,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 250,
          child: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 64,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'SpeakUp',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.house, size: 20),
                  title: const Text('Home'),
                  selected: false,
                  onTap: () => onNavigate('/'),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.clockRotateLeft, size: 20),
                  title: const Text('History'),
                  onTap: () => onNavigate('/history'),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.chartLine, size: 20),
                  title: const Text('Statistics'),
                  onTap: () => onNavigate('/statistics'),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.user, size: 20),
                  title: const Text('Profile'),
                  onTap: () => onNavigate('/profile'),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.gear, size: 20),
                  title: const Text('Settings'),
                  onTap: () => onNavigate('/settings'),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              AppBar(
                title: Text(title),
                actions: actions,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (ResponsiveLayout.isWeb(context))
          SizedBox(
            width: 300,
            child: Card(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Quick Stats',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  _buildQuickActions(context),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SearchBarWidget(
                hintText: 'Search complaints...',
                onChanged: (query) {
                  // Implement search
                },
              ),
            ],
          ),
        ),
        const Divider(),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.plus, size: 18),
          title: const Text('New Complaint'),
          onTap: () {
            // Handle new complaint
          },
        ),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.bell, size: 18),
          title: const Text('Notifications'),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          onTap: () => onNavigate('/notifications'),
        ),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.chartSimple, size: 18),
          title: const Text('Statistics'),
          onTap: () => onNavigate('/statistics'),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _buildRecentActivity(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      children: [
        _buildActivityItem(
          context,
          icon: FontAwesomeIcons.circleCheck,
          title: 'Complaint Resolved',
          subtitle: 'Your complaint #1234 has been resolved',
          time: '2h ago',
          iconColor: Colors.green,
        ),
        _buildActivityItem(
          context,
          icon: FontAwesomeIcons.comment,
          title: 'New Response',
          subtitle: 'Organization responded to your complaint',
          time: '3h ago',
          iconColor: Colors.blue,
        ),
        _buildActivityItem(
          context,
          icon: FontAwesomeIcons.clockRotateLeft,
          title: 'Status Updated',
          subtitle: 'Complaint status changed to "In Progress"',
          time: '5h ago',
          iconColor: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildActivityItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FaIcon(
              icon,
              size: 16,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
} 