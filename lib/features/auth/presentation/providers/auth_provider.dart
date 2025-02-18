import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository;
  User? _currentUser;
  bool _isLoading = false;

  AuthProvider(this._authRepository) {
    _loadCurrentUser();
  }

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> _loadCurrentUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await _authRepository.getCurrentUser();
    } catch (e) {
      debugPrint('Error loading user: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await _authRepository.signInWithGoogle();
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithPhone(String phoneNumber) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await _authRepository.signInWithPhone(phoneNumber);
    } catch (e) {
      debugPrint('Error signing in with phone: $e');
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.signOut();
      _currentUser = null;
    } catch (e) {
      debugPrint('Error signing out: $e');
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }
} 