import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/errors/api_error_handler.dart';
import 'package:todo/core/errors/server_exception.dart';
import 'package:todo/core/network/result_api.dart';
import 'package:todo/features/home/presentation/model/task_model.dart';
import 'package:todo/core/network/app_apis.dart';

class TaskApi {

  Future<String> _getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("token");
    if (token == null) throw Exception("No token found, please login again");
    return token;
  }

  Future<Result<TaskModel>> addTask(TaskModel task) {
    return safeApiCall(() async {
      final token = await _getToken();
      final url = Uri.https(AppApis.baseUrl, AppApis.createTodo);

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(task.toJson()),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }

      final json = jsonDecode(response.body);
      return TaskModel.fromJson(json);
    });
  }

  Future<Result<List<TaskModel>>> getTasks(String id) {
    return safeApiCall(() async {
      final token = await _getToken();
      final url = Uri.https(AppApis.baseUrl, AppApis.getTodoById(id));

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }

      final List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => TaskModel.fromJson(e)).toList();
    });
  }

  Future<Result<TaskModel>> updateTask(TaskModel task) {
    return safeApiCall(() async {
      final token = await _getToken();
      final url = Uri.https(AppApis.baseUrl, AppApis.updateTodo(task.id));

      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(task.toJson()),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }

      final json = jsonDecode(response.body);
      return TaskModel.fromJson(json);
    });
  }

  Future<Result<void>> deleteTask(String id) {
    return safeApiCall(() async {
      final token = await _getToken();
      final url = Uri.https(AppApis.baseUrl, AppApis.deleteTodo(id));

      final response = await http.delete(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }

      return;
    });
  }
}