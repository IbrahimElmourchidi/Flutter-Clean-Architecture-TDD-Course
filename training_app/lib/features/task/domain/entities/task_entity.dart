// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskEntity {
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
}
