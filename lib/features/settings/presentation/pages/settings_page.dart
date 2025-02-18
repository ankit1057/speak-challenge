import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          final settings = provider.settings;
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSection(
                context,
                'Notifications',
                [
                  SwitchListTile(
                    title: const Text('Enable Notifications'),
                    subtitle: const Text('Receive updates about your complaints'),
                    value: settings.notificationsEnabled,
                    onChanged: provider.toggleNotifications,
                  ),
                  if (settings.notificationsEnabled) ...[
                    SwitchListTile(
                      title: const Text('Email Notifications'),
                      subtitle: const Text('Receive updates via email'),
                      value: settings.emailNotifications,
                      onChanged: provider.toggleEmailNotifications,
                    ),
                    SwitchListTile(
                      title: const Text('SMS Notifications'),
                      subtitle: const Text('Receive updates via SMS'),
                      value: settings.smsNotifications,
                      onChanged: provider.toggleSMSNotifications,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                'Appearance',
                [
                  ListTile(
                    title: const Text('Language'),
                    subtitle: Text(settings.language.toUpperCase()),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showLanguageSelector(context),
                  ),
                  ListTile(
                    title: const Text('Theme'),
                    subtitle: Text(settings.theme.capitalize()),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showThemeSelector(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                'About',
                [
                  ListTile(
                    title: const Text('Version'),
                    subtitle: const Text('1.0.0'),
                  ),
                  ListTile(
                    title: const Text('Terms of Service'),
                    onTap: () {
                      // Navigate to Terms of Service
                    },
                  ),
                  ListTile(
                    title: const Text('Privacy Policy'),
                    onTap: () {
                      // Navigate to Privacy Policy
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Future<void> _showLanguageSelector(BuildContext context) async {
    final languages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'es', 'name': 'Español'},
      {'code': 'fr', 'name': 'Français'},
    ];

    final selectedLanguage = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Language'),
        children: languages
            .map(
              (lang) => SimpleDialogOption(
                onPressed: () => Navigator.pop(context, lang['code']),
                child: Text(lang['name']!),
              ),
            )
            .toList(),
      ),
    );

    if (selectedLanguage != null && context.mounted) {
      context.read<SettingsProvider>().updateLanguage(selectedLanguage);
    }
  }

  Future<void> _showThemeSelector(BuildContext context) async {
    final themes = ['light', 'dark', 'system'];

    final selectedTheme = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Theme'),
        children: themes
            .map(
              (theme) => SimpleDialogOption(
                onPressed: () => Navigator.pop(context, theme),
                child: Text(theme.capitalize()),
              ),
            )
            .toList(),
      ),
    );

    if (selectedTheme != null && context.mounted) {
      context.read<SettingsProvider>().updateTheme(selectedTheme);
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
} 