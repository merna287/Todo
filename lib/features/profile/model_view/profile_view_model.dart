import 'package:flutter/material.dart';
import 'package:todo/core/network/result_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/features/auth/presentation/models/user.dart';
import 'package:todo/features/auth/presentation/repo/auth_repo.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthRepo _repo = AuthRepo();

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasLoadedInitialProfile = false;

  String? _error;
  String? get error => _error;

  Future<void> loadCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString('user_name');
    final email = prefs.getString('user_email');

    if (name != null && email != null) {
      _user = User(name: name, email: email);

      _hasLoadedInitialProfile = true;
      notifyListeners();
    }
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

  Future<void> updateName(String newName) async {
    if (_user == null || newName.trim().isEmpty) return;

    _isLoading = true;
    notifyListeners();

    _user!.name = newName.trim();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', newName.trim());

    _isLoading = false;
    notifyListeners();
  }
}
