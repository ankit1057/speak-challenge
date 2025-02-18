class UserSettings {
  final bool notificationsEnabled;
  final String language;
  final String theme;
  final bool emailNotifications;
  final bool smsNotifications;

  const UserSettings({
    this.notificationsEnabled = true,
    this.language = 'en',
    this.theme = 'light',
    this.emailNotifications = true,
    this.smsNotifications = true,
  });

  UserSettings copyWith({
    bool? notificationsEnabled,
    String? language,
    String? theme,
    bool? emailNotifications,
    bool? smsNotifications,
  }) {
    return UserSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
    );
  }
} 