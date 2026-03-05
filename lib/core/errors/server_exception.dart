class ServerException implements Exception {
  const ServerException({required this.statusCode, this.responseBody});
  final int statusCode;
  final String? responseBody;

  @override
  String toString() => 'ServerException(statusCode: $statusCode)';
}
