import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:training_app/core/errors/failure.dart';
import 'package:training_app/features/task/domain/entities/task_entity.dart';
import 'package:training_app/features/task/domain/usecases/create_task.dart';
import 'package:training_app/features/task/domain/usecases/get_all_tasks.dart';
import 'package:training_app/features/task/presentation/cubits/task/task_cubit.dart';

class MockGetAllTasks extends Mock implements GetAllTasks {}

class MockCreateTask extends Mock implements CreateTask {}

void main() {
  late GetAllTasks getAllTasks;
  late CreateTask createTask;
  late TaskCubit cubit;

  final tCreateTaskParams = CreateTaskParams(
    title: 'title',
    tag: 'tag',
    createdAt: DateTime(2024, 12, 8),
  );

  final tTaskList = [
    TaskEntity.empty(),
  ];
  setUp(() {
    getAllTasks = MockGetAllTasks();
    createTask = MockCreateTask();
    cubit = TaskCubit(getAllTasks: getAllTasks, createTask: createTask);
    registerFallbackValue(tCreateTaskParams);
  });

  tearDown(() {
    cubit.close();
  });

  test('every cubit should start with [TaskInitial]', () {
    expect(cubit.state, isA<TaskInitial>());
  });

  group('CreateTask', () {
    blocTest<TaskCubit, TaskState>(
      'should emit [CreatingTask, TaskCreated] when successful',
      build: () {
        when(() => createTask(any()))
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) {
        return cubit.createTask(
          title: tCreateTaskParams.title,
          tag: tCreateTaskParams.tag,
          createdAt: tCreateTaskParams.createdAt,
        );
      },
      expect: () {
        return const [
          CreatingTask(),
          TaskCreated(),
        ];
      },
      verify: (cubit) {
        verify(() => createTask(tCreateTaskParams)).called(1);
        verifyNoMoreInteractions(createTask);
      },
    );

    blocTest<TaskCubit, TaskState>(
      'should emit [CreatingTask, TaskError] when successful',
      build: () {
        when(() => createTask(any())).thenAnswer(
          (_) async => Left(
            APIFailuer(messsage: 'error', statusCode: 505),
          ),
        );
        return cubit;
      },
      act: (cubit) {
        return cubit.createTask(
          title: tCreateTaskParams.title,
          tag: tCreateTaskParams.tag,
          createdAt: tCreateTaskParams.createdAt,
        );
      },
      expect: () {
        return const [
          CreatingTask(),
          TasksError('error'),
        ];
      },
      verify: (cubit) {
        verify(() => createTask(tCreateTaskParams)).called(1);
        verifyNoMoreInteractions(createTask);
      },
    );
  });

  group('GettingAllTasks', () {
    blocTest<TaskCubit, TaskState>(
      'should emit [GettingTasks, TasksLoaded] when successful',
      build: () {
        when(() => getAllTasks()).thenAnswer((_) async => Right(tTaskList));
        return cubit;
      },
      act: (cubit) {
        return cubit.getAllTaks();
      },
      expect: () {
        return [GettingTasks(), TasksLoaded(tTaskList)];
      },
      verify: (cubit) {
        verify(() => getAllTasks()).called(1);
        verifyNoMoreInteractions(getAllTasks);
      },
    );

    blocTest<TaskCubit, TaskState>(
      'should emit [GettingTasks, TasksError] when successful',
      build: () {
        when(() => getAllTasks()).thenAnswer(
          (_) async => Left(
            APIFailuer(messsage: 'error', statusCode: 505),
          ),
        );
        return cubit;
      },
      act: (cubit) {
        return cubit.getAllTaks();
      },
      expect: () {
        return const [GettingTasks(), TasksError('error')];
      },
      verify: (cubit) {
        verify(() => getAllTasks()).called(1);
        verifyNoMoreInteractions(getAllTasks);
      },
    );
  });
}
