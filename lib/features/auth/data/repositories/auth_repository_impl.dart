import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Implementation of [AuthRepository] that uses mock data and SharedPreferences
/// for persistence
class AuthRepositoryImpl implements AuthRepository {
  // Mock storage using Map instead of SharedPreferences for web
  static final Map<String, dynamic> _storage = {};

  // Mock user data
  final _mockUser = User(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    phoneNumber: '+821012345678',
    photoUrl: 'https://ui-avatars.com/api/?name=John+Doe&background=random',
  );

  Future<void> _saveToStorage(String key, dynamic value) async {
    _storage[key] = value;
  }

  Future<dynamic> _getFromStorage(String key) async {
    return _storage[key];
  }

  @override
  Future<User?> getCurrentUser() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Check if user is logged in from SharedPreferences
    final isLoggedIn = await _getFromStorage('isLoggedIn') ?? false;
    
    return isLoggedIn ? _mockUser : null;
  }

  @override
  Future<User> signInWithGoogle() async {
    // Simulate Google Sign In
    await Future.delayed(const Duration(seconds: 2));
    
    // Save login state
    await _saveToStorage('isLoggedIn', true);
    
    return _mockUser;
  }

  @override
  Future<User> signInWithPhone(String phoneNumber) async {
    // Simulate Phone verification
    await Future.delayed(const Duration(seconds: 2));
    
    // Save login state
    await _saveToStorage('isLoggedIn', true);
    
    return _mockUser.copyWith(phoneNumber: phoneNumber);
  }

  @override
  Future<void> signOut() async {
    // Simulate sign out delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Clear login state
    _storage.clear();
  }
}

// Helper extension for User entity
extension UserCopy on User {
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? photoUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
} 