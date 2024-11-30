import 'package:get_it/get_it.dart';
import 'package:training_app/features/task/data/datasources/task_data_source.dart';
import 'package:training_app/features/task/data/datasources/task_remote_data_source.dart';
import 'package:training_app/features/task/data/repos/task_repo_impl.dart';
import 'package:training_app/features/task/domain/repos/task_repo.dart';
import 'package:training_app/features/task/domain/usecases/create_task.dart';
import 'package:training_app/features/task/domain/usecases/get_all_tasks.dart';
import 'package:training_app/features/task/presentation/cubits/task/task_cubit.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> initi() async {
  sl.registerFactory(() => TaskCubit(createTask: sl(), getAllTasks: sl()));
  sl.registerLazySingleton(() => CreateTask(sl()));
  sl.registerLazySingleton(() => GetAllTasks(sl()));
  sl.registerLazySingleton<TaskRepo>(() => TaskRepoImpl(sl()));
  sl.registerLazySingleton<TaskDataSource>(() => TaskRemoteDataSource(sl()));
  sl.registerLazySingleton(() => http.Client());
}
