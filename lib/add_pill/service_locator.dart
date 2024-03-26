import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medicine_app/add_pill/pills/data/pill_repository.dart';
import 'package:medicine_app/add_pill/pills/data/repository_impl.dart';
import 'package:medicine_app/add_pill/pills/data/usecases/add_pill.dart';
import 'package:medicine_app/add_pill/pills/data/usecases/delete_pill.dart';
import 'package:medicine_app/add_pill/pills/data/usecases/get_all_pills.dart';
import 'package:medicine_app/add_pill/pills/data/usecases/update_status.dart';

import 'pills/data/bloc/pill_bloc.dart';
import 'pills/data/local/local_source.dart';

final sl = GetIt.I;

Future<void> init() async {
  //BLoC
  sl.registerFactory(() => PillBloc(
      getAllPills: sl<GetAllPills>(),
      deletePill: sl<DeletePill>(),
      addPill: sl<AddPill>(),
      updateStatus: sl<UpdateStatus>()));

  //UseCases
  sl.registerLazySingleton(() => AddPill(repository: sl()));
  sl.registerLazySingleton(() => DeletePill(repository: sl()));
  sl.registerLazySingleton(() => GetAllPills(repository: sl()));
  sl.registerLazySingleton(() => UpdateStatus(repository: sl()));

  //Repository
  sl.registerLazySingleton<PillRepository>(
      () => RepositoryImpl(localDataSource: sl()));

  //Local DS
  sl.registerLazySingleton<PillLocalDataSource>(
    () => PillLocalDataSourceImpl(),
  );

  //External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
