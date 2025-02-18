import '../../domain/entities/user_profile.dart';
import '../../../../core/services/storage_service.dart';

class ProfileRepositoryImpl {
  final StorageService _storage;
  static const _userProfileKey = 'user_profile';

  ProfileRepositoryImpl(this._storage);

  Future<void> saveProfile(UserProfile profile) async {
    await _storage.saveJson(_userProfileKey, profile.toJson());
  }

  UserProfile? getProfile() {
    final json = _storage.getJson(_userProfileKey);
    if (json != null) {
      return UserProfile.fromJson(json);
    }
    return null;
  }

  Future<void> updateProfile(UserProfile profile) async {
    await saveProfile(profile);
  }

  Future<void> clearProfile() async {
    await _storage.remove(_userProfileKey);
  }
} 