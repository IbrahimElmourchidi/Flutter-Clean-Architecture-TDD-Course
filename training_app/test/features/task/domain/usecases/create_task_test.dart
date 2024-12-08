import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:training_app/core/errors/failure.dart';
import 'package:training_app/core/usecases/usecase.dart';
import 'package:training_app/features/task/domain/repos/task_repo.dart';
import 'package:training_app/features/task/domain/usecases/create_task.dart';

class MockTaskRepo extends Mock implements TaskRepo {}

void main() {
  late CreateTask createTask;
  late TaskRepo repo;

  setUp(() {
    repo = MockTaskRepo();
    createTask = CreateTask(repo);
  });

  test('should implement [TaskDataSource]', () {
    expect(createTask, isA<UseCaseWithParams<void, CreateTaskParams>>());
  });

  test(
    'Should call [TaskRepo.createUser] and return [Right<void>] when call is successful',
    () async {
      // Arrange
      final params = CreateTaskParams.empty();

      when(() => repo.createTask(
            title: any(named: 'title'),
            tag: any(named: 'tag'),
            createdAt: any(named: 'createdAt'),
          )).thenAnswer(
        (_) async {
          return const Right<Failure, void>(null);
        },
      );

      // act
      final result = await createTask(params);

      // assert
      expect(result, equals(const Right<Failure, void>(null)));
      verify(
        () => repo.createTask(
          title: params.title,
          tag: params.tag,
          createdAt: params.createdAt,
        ),
      ).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
