class APIException implements Exception {
  APIException({
    required this.errorMessage,
    required this.statusCode,
  });
  final String errorMessage;
  final int statusCode;

  @override
  String toString() {
    return '$statusCode: $errorMessage';
  }
}
