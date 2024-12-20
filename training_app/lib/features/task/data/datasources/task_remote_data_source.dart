import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:training_app/core/errors/exceptions.dart';

import 'package:training_app/core/utils/constants.dart';
import 'package:training_app/features/task/data/datasources/task_data_source.dart';
import 'package:training_app/features/task/data/models/task_model.dart';

class TaskRemoteDataSource implements TaskDataSource {
  const TaskRemoteDataSource(this._client);

  final http.Client _client;

  Future<void> createTask({
    required String title,
    required String tag,
    required DateTime createdAt,
  }) async {
    final String createdAtString = createdAt.toIso8601String();
    final body = jsonEncode(
      {
        "tag": tag,
        "title": title,
        "createdAt": createdAtString,
      },
    );

    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl/tasks'),
        body: body,
        headers: {
          "content-type": "application/json",
        },
      );
      if (!_isRequestSuccess(response.statusCode)) {
        throw APIException(
          errorMessage: 'Internal Server Error',
          statusCode: response.statusCode,
        );
      }
    } on APIException catch (e) {
      rethrow;
    } catch (e) {
      throw APIException(errorMessage: e.toString(), statusCode: 505);
    }
  }

  Future<List<TaskModel>> getAllTasks() async {
    try {
      final response = await _client.get(Uri.parse('$kBaseUrl/tasks'));
      if (!_isRequestSuccess(response.statusCode)) {
        throw APIException(
          errorMessage: 'Internal Server Error',
          statusCode: response.statusCode,
        );
      }
      final responseBody = response.body;
      final responseObjs = jsonDecode(responseBody) as List<dynamic>;
      final result = responseObjs.map((obj) => TaskModel.fromMap(obj)).toList();
      return result;
    } on APIException catch (e) {
      rethrow;
    } catch (e) {
      throw APIException(errorMessage: e.toString(), statusCode: 505);
    }
  }

  bool _isRequestSuccess(int statusCode) {
    return statusCode >= 200 && statusCode <= 299;
  }
}
