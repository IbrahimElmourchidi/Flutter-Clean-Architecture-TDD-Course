import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:training_app/core/utils/typedef.dart';
import 'package:training_app/features/task/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.title,
    required super.tag,
    required super.createdAt,
    required super.id,
  });

  TaskModel copyWith({
    String? title,
    String? tag,
    DateTime? createdAt,
    int? id,
  }) {
    return TaskModel(
      title: title ?? this.title,
      tag: tag ?? this.tag,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'title': title,
      'tag': tag,
      'createdAt': createdAt.toIso8601String(),
      'id': id.toString(),
    };
  }

  factory TaskModel.fromMap(DataMap map) {
    return TaskModel(
      title: map['title'] as String,
      tag: map['tag'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      id: int.parse(map['id'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskEntity(title: $title, tag: $tag, createdAt: $createdAt, id: $id)';
  }
}
