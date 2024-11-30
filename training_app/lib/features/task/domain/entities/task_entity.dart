// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  TaskEntity({
    required this.title,
    required this.tag,
    required this.createdAt,
    required this.id,
  });

  final String title;
  final String tag;
  final DateTime createdAt;
  final int id;

  @override
  List<Object?> get props => [id, title, tag, createdAt];
}
