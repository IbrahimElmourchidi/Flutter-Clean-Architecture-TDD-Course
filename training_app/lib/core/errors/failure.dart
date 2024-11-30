import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({
    required this.messsage,
    required this.statusCode,
  });

  final String messsage;
  final int statusCode;

  String get errorMessage => '$statusCode: $messsage';

  @override
  List<Object?> get props => [messsage, statusCode];
}

class APIFailuer extends Failure {
  APIFailuer({
    required super.messsage,
    required super.statusCode,
  });
}
