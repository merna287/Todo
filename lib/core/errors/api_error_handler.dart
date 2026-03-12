import 'dart:convert';
import 'dart:io';

import 'package:todo/core/errors/failure.dart';
import 'package:todo/core/errors/server_exception.dart';
import 'package:todo/core/network/result_api.dart';

Future<Result<T>> safeApiCall<T>(Future<T> Function() call) async {
  try {
    final data = await call();
    return SuccessAPI<T>(data);
  } on SocketException {
    return ErrorAPI<T>(const NetworkFailure());
  } on ServerException catch (e) {

    String? serverMessage;

    try {
      if (e.responseBody != null) {
        final jsonBody = jsonDecode(e.responseBody!);
        serverMessage = jsonBody['error'];
      }
    } catch (_) {
      serverMessage = null;
    }

    return ErrorAPI<T>(ServerFailure(
      statusCode: e.statusCode,
      serverMessage: serverMessage,
    ));

  } on FormatException {
    return ErrorAPI<T>(const ParsingFailure());
  } catch (e) {
    if (e is Failure) return ErrorAPI<T>(e);
    return ErrorAPI<T>(UnknownFailure(e.toString()));
  }
}