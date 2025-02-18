import 'package:flutter/foundation.dart';
import '../../domain/entities/user_profile.dart';
import '../../data/repositories/profile_repository_impl.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepositoryImpl _repository;
  UserProfile? _profile;
  bool _isLoading = false;

  ProfileProvider(this._repository) {
    _loadProfile();
  }

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> _loadProfile() async {
    _isLoading = true;
    notifyListeners();

    _profile = _repository.getProfile();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(UserProfile updatedProfile) async {
    _isLoading = true;
    notifyListeners();

    await _repository.updateProfile(updatedProfile);
    _profile = updatedProfile;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> clearProfile() async {
    _isLoading = true;
    notifyListeners();

    await _repository.clearProfile();
    _profile = null;

    _isLoading = false;
    notifyListeners();
  }
} 