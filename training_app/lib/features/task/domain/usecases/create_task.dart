import 'package:training_app/core/usecases/usecase.dart';
import 'package:training_app/core/utils/typedef.dart';
import 'package:training_app/features/task/domain/repos/task_repo.dart';

class CreateTask implements UseCaseWithParams<void, CreateTaskParams> {
  const CreateTask(this._repo);
  final TaskRepo _repo;

  @override
  FutureResult<void> call(CreateTaskParams params) async {
    await _repo.createTask(
      title: params.title,
      tag: params.tag,
      createdAt: params.createdAt,
    );
  }
}

class CreateTaskParams {
  CreateTaskParams({
    required this.title,
    required this.tag,
    required this.createdAt,
  });
  final String title;
  final String tag;
  final DateTime createdAt;
}
