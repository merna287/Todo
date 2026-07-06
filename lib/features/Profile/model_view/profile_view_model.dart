import 'package:flutter/material.dart';
import 'package:todo/core/network/result_api.dart';
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

  Future<void> fetchProfile({bool forceRefresh = false}) async {
    if (!forceRefresh && _hasLoadedInitialProfile && _user != null) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    final result = await _repo.getProfile();

    if (result is SuccessAPI<User>) {
      _user = result.data;
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

  _isLoading = false;
  notifyListeners();
}
}