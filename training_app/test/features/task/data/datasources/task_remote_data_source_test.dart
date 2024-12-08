import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:training_app/core/errors/exceptions.dart';
import 'package:training_app/core/utils/constants.dart';
import 'package:training_app/features/task/data/datasources/task_data_source.dart';
import 'package:training_app/features/task/data/datasources/task_remote_data_source.dart';
import 'package:training_app/features/task/data/models/task_model.dart';

import '../repos/task_repo_impl_test.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late TaskDataSource taskRemoteDataSource;

  setUp(() {
    client = MockHttpClient();
    taskRemoteDataSource = TaskRemoteDataSource(client);
    registerFallbackValue(Uri());
  });

  test('should implement [TaskDataSource]', () {
    expect(taskRemoteDataSource, isA<TaskDataSource>());
  });

  group('createTask', () {
    final body = jsonEncode({
      'tag': 'tag',
      "title": 'title',
      'createdAt': DateTime(2024, 12, 8).toIso8601String(),
    });
    test(
      'Should call the server and return [void] when the call is successfull',
      () async {
        // arrange
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => http.Response('ok', 201));

        // final result = taskRemoteDataSource.createTask;

        // // assert
        // expect(
        //   result(
        //     title: 'title',
        //     tag: 'tag',
        //     createdAt: DateTime(2024, 12, 8),
        //   ),
        //   completes,
        // );

        // act
        final result = taskRemoteDataSource.createTask(
          title: 'title',
          tag: 'tag',
          createdAt: DateTime(2024, 12, 8),
        );

        //assert
        expectLater(result, completes);

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl/tasks'),
            body: body,
            headers: {
              "content-type": "application/json",
            },
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should call server and return [APIException] when call is unseuccessfull',
      () async {
        // arrange
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => http.Response('ok', 400));

        // act
        // final result = taskRemoteDataSource.createTask;

        // expect(
        //   result(title: 'title', tag: 'tag', createdAt: DateTime(2024, 12, 7)),
        //   throwsA(
        //     APIException(
        //       errorMessage: 'Internal Server Error',
        //       statusCode: 400,
        //     ),
        //   ),
        // );

        //act
        final result = taskRemoteDataSource.createTask(
          title: 'title',
          tag: 'tag',
          createdAt: DateTime(2024, 12, 8),
        );

        // assert
        expectLater(
          result,
          throwsA(
            APIException(
                errorMessage: 'Internal Server Error', statusCode: 400),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl/tasks'),
            body: body,
            headers: {
              "content-type": "application/json",
            },
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group(
    'getAllTasks',
    () {
      final tTaskList = [
        TaskModel(
          title: 'title',
          tag: 'tag',
          createdAt: DateTime(2024, 12, 8),
          id: 0,
        ),
      ];
      test(
        'should call server and return [List<TaskModel>] when call is successful',
        () async {
          // arrange
          when(() => client.get(any())).thenAnswer((_) async =>
              http.Response(jsonEncode([tTaskList[0].toMap()]), 200));

          // act
          final result = await taskRemoteDataSource.getAllTasks();

          // assert
          expect(result, isA<List<TaskModel>>());
          verify(() => client.get(Uri.parse('$kBaseUrl/tasks'))).called(1);
          verifyNoMoreInteractions(client);
        },
      );

      test(
        'should call server and return [APIException] when call is not successful',
        () async {
          // arrange
          when(() => client.get(any()))
              .thenAnswer((_) async => http.Response('error', 400));
          // act
          final result = taskRemoteDataSource.getAllTasks();

          // assert
          expectLater(
            result,
            throwsA(
              APIException(
                  errorMessage: 'Internal Server Error', statusCode: 400),
            ),
          );

          verify(() => client.get(Uri.parse('$kBaseUrl/tasks'))).called(1);
          verifyNoMoreInteractions(client);
        },
      );
    },
  );
}
