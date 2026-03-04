import 'package:todo/core/errors/failure.dart';

sealed class Result<T> {}

class SuccessAPI<T> extends Result<T> {
  SuccessAPI(this.data);
  final T data;
}

class ErrorAPI<T> extends Result<T> {
  ErrorAPI(this.failure);
  final Failure failure;
}
