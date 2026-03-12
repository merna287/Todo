sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

class ServerFailure extends Failure {
  const ServerFailure({this.statusCode, this.serverMessage})
      : super(serverMessage ?? 'Something went wrong on the server');

  final int? statusCode;
  final String? serverMessage;
}

class ParsingFailure extends Failure {
  const ParsingFailure([super.message = 'Failed to parse response']);
}

class AuthFailure extends Failure {
  AuthFailure([String? customMessage])
      : super(customMessage ?? "Email or password is incorrect");
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Something went wrong']);
}

extension FailureMessage on Failure {
  String get userMessage => switch (this) {
        NetworkFailure() => 'Please check your internet connection',
        ServerFailure(statusCode: 400, serverMessage: var msg) =>
            msg ?? 'Bad request',
        ServerFailure(statusCode: 404) => 'Content not found',
        ServerFailure(statusCode: 500) =>
            'Server is having issues, try again later',
        ServerFailure(serverMessage: var msg) =>
            msg ?? 'Something went wrong on the server',
        ParsingFailure() => 'Unexpected response format',
        AuthFailure() => message,
        UnknownFailure() => message,
      };
}