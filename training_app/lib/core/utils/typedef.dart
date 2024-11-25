import 'package:dartz/dartz.dart';
import 'package:training_app/core/errors/failure.dart';

typedef FutureResult<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
