import 'package:dartz/dartz.dart';
import 'package:training_app/core/utils/typedef.dart';
import 'package:training_app/features/task/domain/entities/task_entity.dart';

abstract class TaskRepo {
  const TaskRepo();

  FutureResult<void> createTask({
    required String title,
    required String tag,
    required DateTime createdAt,
  });

  FutureResult<List<TaskEntity>> getAllTasks();
}
