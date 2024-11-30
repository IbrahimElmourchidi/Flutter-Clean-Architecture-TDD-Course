import 'package:flutter/material.dart';
import 'package:training_app/features/task/presentation/widgets/add_task_dialog.dart';
import 'package:training_app/features/task/presentation/widgets/tasks_list.dart';

class TasksHome extends StatelessWidget {
  const TasksHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Tasks",
          style: TextStyle(
            color: Color(0xff2b1887),
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: TasksList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (context) {
                  return AddTaskDialog();
                });
          },
          label: const Text('Add New Task')),
    );
  }
}
