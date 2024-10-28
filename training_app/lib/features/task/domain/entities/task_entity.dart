class TaskEntity {
  TaskEntity({
    required this.title,
    required this.tag,
    required this.createdAt,
  });

  final String title;
  final String tag;
  final DateTime createdAt;
}
