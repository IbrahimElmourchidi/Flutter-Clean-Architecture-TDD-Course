import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:training_app/core/errors/failure.dart';
import 'package:training_app/core/usecases/usecase.dart';
import 'package:training_app/features/task/domain/entities/task_entity.dart';
import 'package:training_app/features/task/domain/repos/task_repo.dart';
import 'package:training_app/features/task/domain/usecases/get_all_tasks.dart';

class MockTaskRepo extends Mock implements TaskRepo {}

void main() {
  late TaskRepo repo;
  late GetAllTasks getAllTasks;

  setUp(() {
    repo = MockTaskRepo();
    getAllTasks = GetAllTasks(repo);
  });
  test('should implement [TaskDataSource]', () {
    expect(getAllTasks, isA<UseCase<List<TaskEntity>>>());
  });
  test(
    'should call [TaskRepo.getAllTasks] and return [Right<List<TaskEntity>>] when success',
    () async {
      //Arrange
      final testingTasks = [
        TaskEntity.empty(),
      ];

      when(() => repo.getAllTasks()).thenAnswer(
        (_) async => Right(testingTasks),
      );

      // Act
      final result = await getAllTasks();

      // Assert
      expect(result, equals(Right<Failure, List<TaskEntity>>(testingTasks)));
      verify(() => repo.getAllTasks()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
