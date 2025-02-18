import 'package:flutter/foundation.dart';
import '../../domain/entities/user_settings.dart';

class SettingsProvider with ChangeNotifier {
  UserSettings _settings = const UserSettings();

  UserSettings get settings => _settings;

  Future<void> updateSettings(UserSettings newSettings) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    _settings = newSettings;
    notifyListeners();
  }

  Future<void> toggleNotifications(bool enabled) async {
    await updateSettings(_settings.copyWith(notificationsEnabled: enabled));
  }

  Future<void> updateLanguage(String language) async {
    await updateSettings(_settings.copyWith(language: language));
  }

  Future<void> updateTheme(String theme) async {
    await updateSettings(_settings.copyWith(theme: theme));
  }

  Future<void> toggleEmailNotifications(bool enabled) async {
    await updateSettings(_settings.copyWith(emailNotifications: enabled));
  }

  Future<void> toggleSMSNotifications(bool enabled) async {
    await updateSettings(_settings.copyWith(smsNotifications: enabled));
  }
} 