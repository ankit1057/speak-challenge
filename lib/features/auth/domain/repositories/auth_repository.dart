import '../entities/user.dart';

abstract class AuthRepository {
  Future<User?> getCurrentUser();
  Future<User> signInWithGoogle();
  Future<User> signInWithPhone(String phoneNumber);
  Future<void> signOut();
} 