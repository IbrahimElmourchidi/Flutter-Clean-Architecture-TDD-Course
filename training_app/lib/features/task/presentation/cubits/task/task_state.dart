part of 'task_cubit.dart';

@immutable
sealed class TaskState extends Equatable {
  const TaskState();
  @override
  List<Object?> get props => [];
}

final class TaskInitial extends TaskState {
  const TaskInitial();
}

final class GettingTasks extends TaskState {
  const GettingTasks();
}

final class TasksLoaded extends TaskState {
  const TasksLoaded(this.tasks);
  final List<TaskEntity> tasks;
  @override
  List<Object?> get props => [tasks];
}

final class TasksError extends TaskState {
  const TasksError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

final class CreatingTask extends TaskState {
  const CreatingTask();
}

final class TaskCreated extends TaskState {
  const TaskCreated();
}
