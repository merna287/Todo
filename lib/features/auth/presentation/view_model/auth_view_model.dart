import 'package:flutter/material.dart';
import 'package:todo/core/network/result_api.dart';
import 'package:todo/core/services/auth_service.dart';
import 'package:todo/features/auth/presentation/models/login_request.dart';
import 'package:todo/features/auth/presentation/models/login_response.dart';
import 'package:todo/features/auth/presentation/models/register_request.dart';
import 'package:todo/features/auth/presentation/models/register_response.dart';
import 'package:todo/features/auth/presentation/repo/auth_repo.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepo _repo = AuthRepo();

  Future<Result<LoginResponse>> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final result = await _repo.login(request);

    if (result is SuccessAPI<LoginResponse>) {
      final data = result.data;
      final token = data.token;

      if (token != null && token.isNotEmpty) {
        await AuthService.instance.saveToken(token);
      }
    }

    return result;
  }

  Future<Result<RegisterResponse>> register(
    String name,
    String email,
    String password,
  ) async {
    final request = RegisterRequest(
      name: name,
      email: email,
      password: password,
    );
    final result = await _repo.register(request);

    if (result is SuccessAPI<RegisterResponse>) {
      final data = result.data;
      final token = data.token;

      if (token != null && token.isNotEmpty) {
        await AuthService.instance.saveToken(token);
      }
    }

    return result;
  }
}
