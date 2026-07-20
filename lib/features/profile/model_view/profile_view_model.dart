import 'package:flutter/material.dart';
import 'package:todo/core/network/result_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/features/auth/presentation/models/user.dart';
import 'package:todo/features/auth/presentation/repo/auth_repo.dart';
import 'package:todo/features/profile/model_view/update_profile_request.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthRepo _repo = AuthRepo();

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasLoadedInitialProfile = false;

  String? _error;
  String? get error => _error;

  String? _avatarSeed;
  String? get avatarSeed => _avatarSeed;

  Color _avatarColor = AppColors.secondColor;
  Color get avatarColor => _avatarColor;

  void reset() {
    _user = null;
    _error = null;
    _hasLoadedInitialProfile = false;

    _avatarSeed = null;
    _avatarColor = AppColors.secondColor;
    notifyListeners();
  }

  Future<void> loadCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString('user_name');
    final email = prefs.getString('user_email');

    if (name != null && email != null) {
      _user = User(name: name, email: email);
      _hasLoadedInitialProfile = true;
    }

    await loadAvatar();
    notifyListeners();
  }

  Future<void> fetchProfile({bool forceRefresh = false}) async {
    if (!forceRefresh && _hasLoadedInitialProfile && _user != null) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    final result = await _repo.getProfile();

    if (result is SuccessAPI<User>) {
      _user = result.data;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', _user!.name);
      await prefs.setString('user_email', _user!.email);

      _error = null;
      _hasLoadedInitialProfile = true;
    } else if (result is ErrorAPI<User>) {
      _error = result.failure.message;
    }

    _isLoading = false;
    notifyListeners();
  }


  Future<void> updateProfile(
    String newName,
    String newEmail,
    String newPassword,
  ) async {
    if (_user == null) return;

    _isLoading = true;
    notifyListeners();

    final result = await _repo.updateProfile(
      UpdateProfileRequest(
        name: newName.trim(),
        email: newEmail.trim(),
        password: newPassword.trim(),
      ),
    );

    if (result is SuccessAPI<User>) {
      _user = result.data;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', _user!.name);
      await prefs.setString('user_email', _user!.email);

      _error = null;
    } else if (result is ErrorAPI<User>) {
      _error = result.failure.message;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveAvatar({
    String? seed,
    required Color color,
  }) async {
    _avatarSeed = seed;
    _avatarColor = color;

    final prefs = await SharedPreferences.getInstance();

    if (seed == null) {
      await prefs.remove("avatar_seed");
    } else {
      await prefs.setString("avatar_seed", seed);
    }

    await prefs.setInt(
      "avatar_color",
      color.toARGB32(),
    );

    notifyListeners();
  }

  Future<void> loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();

    _avatarSeed = prefs.getString("avatar_seed");

    final colorValue = prefs.getInt("avatar_color");

    if (colorValue != null) {
      _avatarColor = Color(colorValue);
    }

    notifyListeners();
  }
}
