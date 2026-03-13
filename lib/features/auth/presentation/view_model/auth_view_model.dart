
import 'package:flutter/material.dart';
import 'package:todo/core/network/result_api.dart';
import 'package:todo/features/auth/presentation/models/login_request.dart';
import 'package:todo/features/auth/presentation/models/login_response.dart';
import 'package:todo/features/auth/presentation/models/register_request.dart';
import 'package:todo/features/auth/presentation/models/register_response.dart';
import 'package:todo/features/auth/presentation/repo/auth_repo.dart';

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;
  final AuthRepo _repo = AuthRepo();

  Future<Result<LoginResponse>> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    return await _repo.login(request);
  }

  Future<Result<RegisterResponse>> register(String name, String email, String password) async {
    final request = RegisterRequest(name: name, email: email, password: password);
    return await _repo.register(request);
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}