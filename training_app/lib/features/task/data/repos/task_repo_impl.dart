import 'package:dartz/dartz.dart';
import 'package:training_app/core/errors/exceptions.dart';
import 'package:training_app/core/errors/failure.dart';
import 'package:training_app/core/utils/typedef.dart';
import 'package:training_app/features/task/data/datasources/task_data_source.dart';
import 'package:training_app/features/task/data/datasources/task_remote_data_source.dart';
import 'package:training_app/features/task/domain/entities/task_entity.dart';
import 'package:training_app/features/task/domain/repos/task_repo.dart';

class TaskRepoImpl implements TaskRepo {
  const TaskRepoImpl(this._datasource);

  final TaskDataSource _datasource;

  @override
  FutureResult<void> createTask({
    required String title,
    required String tag,
    required DateTime createdAt,
  }) async {
    try {
      await _datasource.createTask(
        title: title,
        tag: tag,
        createdAt: createdAt,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(
        APIFailuer(messsage: e.errorMessage, statusCode: e.statusCode),
      );
    }
  }

  @override
  FutureResult<List<TaskEntity>> getAllTasks() async {
    try {
      final result = await _datasource.getAllTasks();
      return Right(result);
    } on APIException catch (e) {
      return Left(
          APIFailuer(messsage: e.errorMessage, statusCode: e.statusCode));
    }
  }
}
