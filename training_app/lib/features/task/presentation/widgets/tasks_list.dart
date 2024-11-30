import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:training_app/features/task/domain/entities/task_entity.dart';
import 'package:training_app/features/task/presentation/cubits/task/task_cubit.dart';
import 'package:training_app/features/task/presentation/widgets/loading_column.dart';
import 'package:training_app/features/task/presentation/widgets/task_card.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    super.key,
  });

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  void getAllTasks() async {
    await context.read<TaskCubit>().getAllTaks();
  }

  @override
  void initState() {
    super.initState();
    getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TasksError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is TaskCreated) {
          getAllTasks();
        }
      },
      builder: (context, state) {
        if (state is GettingTasks) {
          return const LoadingColumn(
            message: 'fetching tasks',
          );
        } else if (state is CreatingTask) {
          return const LoadingColumn(
            message: 'Creating Task',
          );
        } else if (state is TasksLoaded) {
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, idx) {
              return TaskCard(
                task: state.tasks[idx],
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
