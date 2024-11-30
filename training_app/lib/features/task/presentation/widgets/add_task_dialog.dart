import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/features/task/presentation/cubits/task/task_cubit.dart';
import 'package:training_app/features/task/presentation/widgets/tasks_list.dart';

class AddTaskDialog extends StatelessWidget {
  AddTaskDialog({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 300,
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'title',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: tagController,
              decoration: const InputDecoration(
                labelText: 'tag',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {
                    context.read<TaskCubit>().createTask(
                          title: titleController.text,
                          tag: tagController.text,
                          createdAt: DateTime.now(),
                        );
                    Navigator.pop(context);
                  },
                  child: const Text('Create'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
