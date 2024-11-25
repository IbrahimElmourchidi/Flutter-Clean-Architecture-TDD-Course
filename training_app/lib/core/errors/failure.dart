abstract class Failure {
  Failure({
    required this.messsage,
    required this.statusCode,
  });

  final String messsage;
  final int statusCode;

  String get errorMessage => '$statusCode: $messsage';
}

class APIFailuer extends Failure {
  APIFailuer({
    required super.messsage,
    required super.statusCode,
  });
}
