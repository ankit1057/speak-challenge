class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? photoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.photoUrl,
  });
} 