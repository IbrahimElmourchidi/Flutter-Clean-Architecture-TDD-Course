import 'package:training_app/core/usecases/usecase.dart';
import 'package:training_app/core/utils/typedef.dart';
import 'package:training_app/features/task/domain/entities/task_entity.dart';
import 'package:training_app/features/task/domain/repos/task_repo.dart';

class GetAllTasks implements UseCase<List<TaskEntity>> {
  GetAllTasks(this._repo);
  final TaskRepo _repo;

  @override
  FutureResult<List<TaskEntity>> call() async {
    return await _repo.getAllTasks();
  }
}
