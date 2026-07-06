import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/errors/api_error_handler.dart';
import 'package:todo/core/errors/failure.dart';
import 'package:todo/core/errors/server_exception.dart';
import 'package:todo/core/network/app_apis.dart';
import 'package:todo/core/network/result_api.dart';
import 'package:todo/features/auth/presentation/models/login_request.dart';
import 'package:todo/features/auth/presentation/models/login_response.dart';
import 'package:todo/features/auth/presentation/models/register_request.dart';
import 'package:todo/features/auth/presentation/models/register_response.dart';
import 'package:todo/features/auth/presentation/models/user.dart';

class AuthRepo {
  Future<Result<LoginResponse>> login(LoginRequest request) {
    return safeApiCall(() async {
      final url = Uri.https(AppApis.baseUrl, AppApis.login);
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(request.toJson()),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");
      if (response.statusCode == 401) {
        throw AuthFailure();
      } else if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }

      final json = jsonDecode(response.body);
      return LoginResponse.fromJson(json);
    });
  }

  Future<Result<RegisterResponse>> register(RegisterRequest request) {
    return safeApiCall(() async {
      final url = Uri.https(AppApis.baseUrl, AppApis.register);

print(url);
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(request.toJson()),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");
      if (response.statusCode == 401) {
        throw AuthFailure();
      } else if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }

      final json = jsonDecode(response.body);
      return RegisterResponse.fromJson(json);
    });
  }
  Future<Result<User>> getProfile() {
    return safeApiCall(() async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString("token");

      final url = Uri.https(AppApis.baseUrl, AppApis.getProfile);

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 401) {
        throw AuthFailure();
      } else if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }

      final json = jsonDecode(response.body);

      return User.fromJson(json);
    });
  }

//   Future<Result<User>> updateProfile(String newName) {
//   return safeApiCall(() async {
//     final url = Uri.https(AppApis.baseUrl, AppApis.updateProfile);

//     final response = await http.put(
//       url,
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $token",
//       },
//       body: jsonEncode({
//         "name": newName,
//       }),
//     );

//     if (response.statusCode < 200 || response.statusCode >= 300) {
//       throw ServerException(
//         statusCode: response.statusCode,
//         responseBody: response.body,
//       );
//     }

//     return User.fromJson(jsonDecode(response.body));
//   });
// }
}