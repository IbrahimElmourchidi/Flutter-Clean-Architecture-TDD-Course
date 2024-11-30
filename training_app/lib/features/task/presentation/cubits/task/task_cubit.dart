import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:training_app/features/task/domain/entities/task_entity.dart';
import 'package:training_app/features/task/domain/usecases/create_task.dart';
import 'package:training_app/features/task/domain/usecases/get_all_tasks.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit({
    required GetAllTasks getAllTasks,
    required CreateTask createTask,
  })  : _getAllTasks = getAllTasks,
        _createTask = createTask,
        super(TaskInitial());

  final GetAllTasks _getAllTasks;
  final CreateTask _createTask;

  Future<void> createTask({
    required String title,
    required String tag,
    required DateTime createdAt,
  }) async {
    emit(const CreatingTask());
    final result = await _createTask(
      CreateTaskParams(
        title: title,
        tag: tag,
        createdAt: createdAt,
      ),
    );
    result.fold((failure) {
      emit(TasksError(failure.errorMessage));
    }, (data) {
      emit(const TaskCreated());
    });
  }

  Future<void> getAllTaks() async {
    emit(const GettingTasks());
    final result = await _getAllTasks();
    result.fold((failure) {
      emit(TasksError(failure.errorMessage));
    }, (data) {
      emit(TasksLoaded(data));
    });
  }
}
