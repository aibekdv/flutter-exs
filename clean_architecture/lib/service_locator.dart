import 'package:clean_architecture/core/platforms/network_info.dart';
import 'package:clean_architecture/feature/data/datasources/person_local_datasource.dart';
import 'package:clean_architecture/feature/data/datasources/person_remote_datasource.dart';
import 'package:clean_architecture/feature/data/repositories/person_repository_impl.dart';
import 'package:clean_architecture/feature/domain/repositories/person_repository.dart';
import 'package:clean_architecture/feature/domain/usecases/get_all_persons.dart';
import 'package:clean_architecture/feature/domain/usecases/search_person.dart';
import 'package:clean_architecture/feature/presentation/bloc/person_list/person_list_cubit.dart';
import 'package:clean_architecture/feature/presentation/bloc/search/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLOC and CUBIT
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => SearchBloc(searchPerson: sl()));

  // USECASE
  sl.registerLazySingleton(() => SearchPerson(sl()));
  sl.registerLazySingleton(() => GetAllPersons(sl()));

  // REPOSITORY
  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<PersonRemoteDataSource>(
    () => PersonRemoteDataSourceImpl(client: http.Client()),
  );
  sl.registerLazySingleton<PersonLocalDataSource>(
    () => PersonLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // CORE
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

  // EXTERNAL
  final sharedPrefences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
