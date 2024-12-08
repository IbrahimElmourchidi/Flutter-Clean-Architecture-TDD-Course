import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:training_app/core/errors/exceptions.dart';
import 'package:training_app/core/errors/failure.dart';
import 'package:training_app/features/task/data/datasources/task_remote_data_source.dart';
import 'package:training_app/features/task/data/models/task_model.dart';
import 'package:training_app/features/task/data/repos/task_repo_impl.dart';
import 'package:training_app/features/task/domain/entities/task_entity.dart';
import 'package:training_app/features/task/domain/repos/task_repo.dart';

class MockRemoteDataSource extends Mock implements TaskRemoteDataSource {}

void main() {
  late TaskRemoteDataSource remoteDataSouce;
  late TaskRepo taskRepoImpl;
  const title = '';
  const tag = '';
  final createdAt = DateTime(2024, 12, 3);
  setUp(() {
    remoteDataSouce = MockRemoteDataSource();
    taskRepoImpl = TaskRepoImpl(remoteDataSouce);
  });

  test('should implement [TaskDataSource]', () {
    expect(taskRepoImpl, isA<TaskRepo>());
  });
  group('create task', () {
    test(
      'should call [RemoteDataSource.createTask] and return [Right<void>] when call is successfull',
      () async {
        // Arrange
        when(
          () => remoteDataSouce.createTask(
            title: any(named: 'title'),
            tag: any(named: 'tag'),
            createdAt: any(named: 'createdAt'),
          ),
        ).thenAnswer((_) => Future.value(null));
        // act
        final result = await taskRepoImpl.createTask(
          title: title,
          tag: tag,
          createdAt: createdAt,
        );

        // assert
        expect(result, equals(const Right<Failure, void>(null)));
        verify(() => remoteDataSouce.createTask(
              title: title,
              tag: tag,
              createdAt: createdAt,
            )).called(1);
        verifyNoMoreInteractions(remoteDataSouce);
      },
    );

    test(
      'should call [RemoteDataSource.createTask] and return [Left<APIFailure>] when call is unsuccessfull',
      () async {
        //Arrange
        when(
          () => remoteDataSouce.createTask(
            title: any(named: 'title'),
            tag: any(named: 'tag'),
            createdAt: any(named: 'createdAt'),
          ),
        ).thenThrow(
          APIException(errorMessage: 'testErrorMessage', statusCode: 505),
        );

        // Act
        final result = await taskRepoImpl.createTask(
          title: title,
          tag: tag,
          createdAt: createdAt,
        );

        // assert
        expect(
          result,
          equals(
            Left(
              APIFailuer(messsage: 'testErrorMessage', statusCode: 505),
            ),
          ),
        );
      },
    );
  });

  group('get all tasks', () {
    List<TaskModel> tTasks = [
      TaskModel(
        title: title,
        tag: tag,
        createdAt: createdAt,
        id: 1,
      ),
    ];
    test(
      'should call [RemoteDataSource.getAllTasks] and return [Right<List<TaskEntity>>] when call is successful',
      () async {
        //Arrange
        when(() => remoteDataSouce.getAllTasks())
            .thenAnswer((_) async => Future.value(tTasks));

        // Act
        final result = await taskRepoImpl.getAllTasks();

        // assert
        expect(result, equals(Right<Failure, List<TaskEntity>>(tTasks)));
        verify(() => remoteDataSouce.getAllTasks()).called(1);
        verifyNoMoreInteractions(remoteDataSouce);
      },
    );

    test(
      'should call [RemoteDataSource.getAllTasks] and return [Left<ApiFailure>] when call is unsuccessfull',
      () async {
        // Arrange
        when(() => remoteDataSouce.getAllTasks()).thenThrow(
            APIException(errorMessage: 'errorMessage', statusCode: 505));
        // act
        final result = await taskRepoImpl.getAllTasks();

        // assert
        expect(
          result,
          Left(
            APIFailuer(messsage: 'errorMessage', statusCode: 505),
          ),
        );

        verify(() => remoteDataSouce.getAllTasks()).called(1);
        verifyNoMoreInteractions(remoteDataSouce);
      },
    );
  });
}
