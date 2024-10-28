import 'package:training_app/core/utils/typedef.dart';

abstract class UseCase<T> {
  const UseCase();
  FutureResult<T> call();
}

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();
  FutureResult<T> call(Params params);
}
