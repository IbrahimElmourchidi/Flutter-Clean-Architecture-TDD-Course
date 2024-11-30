import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/core/services/service_locator.dart';
import 'package:training_app/features/task/data/datasources/task_remote_data_source.dart';
import 'package:training_app/features/task/data/repos/task_repo_impl.dart';
import 'package:training_app/features/task/domain/usecases/create_task.dart';
import 'package:training_app/features/task/domain/usecases/get_all_tasks.dart';
import 'package:training_app/features/task/presentation/cubits/task/task_cubit.dart';
import 'package:training_app/features/task/presentation/screens/tasks_home.dart';

import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initi();
  runApp(const TrainingApp());
}

class TrainingApp extends StatelessWidget {
  const TrainingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TaskCubit>(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffd5ccff),
        ),
        home: const TasksHome(),
      ),
    );
  }
}
