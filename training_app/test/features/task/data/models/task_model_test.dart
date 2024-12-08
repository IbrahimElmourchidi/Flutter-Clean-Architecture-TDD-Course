import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/core/utils/typedef.dart';
import 'package:training_app/features/task/data/models/task_model.dart';
import 'package:training_app/features/task/domain/entities/task_entity.dart';
import 'dart:io';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tModel = TaskModel(
    title: 'title',
    tag: 'tag',
    createdAt: DateTime(2024, 12, 8),
    id: 0,
  );

  final String tJson = fixture('task.json')
      .replaceAll('\n', '')
      .replaceAll('\r', '')
      .replaceAll(' ', '');

  final tMap = jsonDecode(tJson);

  test('should implement [TaskEntity]', () {
    expect(tModel, isA<TaskEntity>());
  });

  group("fromMap", () {
    test(
      'should return [TaskModel] when data is correct data',
      () {
        // act
        final result = TaskModel.fromMap(tMap);

        // assert
        expect(result, tModel);
      },
    );
  });
  group("toMap", () {
    test(
      'should return [DataMap] when data is correct data',
      () {
        // act
        final result = tModel.toMap();
        // assert
        expect(result, tMap);
      },
    );
  });

  group('toJson', () {
    test('should return [JSON string] when data is correct', () {
      //act
      final result = tModel.toJson();
      //assert
      expect(result, tJson);
    });
  });

  group('fromJson', () {
    test('should return [Task Model] when data is correct', () {
      //act
      final result = TaskModel.fromJson(tJson);
      //assert
      expect(result, tModel);
    });
  });

  group('copyWith', () {
    test('should return [ new Task Model] when data is correct', () {
      //act
      final result = tModel.copyWith(title: 'newTitle');
      //assert
      expect(result.title, 'newTitle');
      expect(result.tag, tModel.tag);
      expect(result.id, tModel.id);
      expect(result.createdAt, tModel.createdAt);
    });
  });
}
