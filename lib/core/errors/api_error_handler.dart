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
    return ErrorAPI<T>(ServerFailure(
      statusCode: e.statusCode,
      message: 'Server responded with ${e.statusCode}',
    ));
  } on FormatException {
    return ErrorAPI<T>(const ParsingFailure());
  } catch (e) {
    return ErrorAPI<T>(UnknownFailure(e.toString()));
  }
}