import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_app/features/task/domain/entities/task_entity.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.task,
    super.key,
  });

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        minVerticalPadding: 20,
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('dd MMM y').format(task.createdAt),
              ),
              Text(task.tag)
            ],
          ),
        ),
      ),
    );
  }
}
