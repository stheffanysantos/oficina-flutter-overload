import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rotina_limpo/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:rotina_limpo/features/auth/data/datasources/fake_auth_remote_datasource.dart';
import 'package:rotina_limpo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:rotina_limpo/features/auth/domain/repositories/auth_repository.dart';
import 'package:rotina_limpo/features/auth/domain/usecases/get_current_user.dart';
import 'package:rotina_limpo/features/auth/domain/usecases/login.dart';
import 'package:rotina_limpo/features/auth/domain/usecases/logout.dart';
import 'package:rotina_limpo/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:rotina_limpo/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:rotina_limpo/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:rotina_limpo/features/tasks/domain/repositories/task_repository.dart';
import 'package:rotina_limpo/features/tasks/domain/usecases/add_task.dart';
import 'package:rotina_limpo/features/tasks/domain/usecases/get_tasks.dart';
import 'package:rotina_limpo/features/tasks/domain/usecases/toggle_task.dart';
import 'package:rotina_limpo/features/tasks/presentation/view_model/tasks_view_model.dart';
import 'package:rotina_limpo/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:rotina_limpo/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:rotina_limpo/features/weather/domain/repositories/weather_repository.dart';
import 'package:rotina_limpo/features/weather/domain/usecases/get_current_weather.dart';
import 'package:rotina_limpo/features/weather/presentation/view_model/weather_view_model.dart';

/// Localizador de dependências: é o único lugar que conhece as classes concretas.
final sl = GetIt.instance;

void setupDi() {
  // Externos
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Auth
  sl.registerLazySingleton<FakeAuthRemoteDataSource>(
    () => FakeAuthRemoteDataSource(),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(sl<FlutterSecureStorage>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<FakeAuthRemoteDataSource>(),
      sl<AuthLocalDataSource>(),
    ),
  );
  sl.registerFactory<AuthViewModel>(
    () => AuthViewModel(
      login: Login(sl<AuthRepository>()),
      logout: Logout(sl<AuthRepository>()),
      getCurrentUser: GetCurrentUser(sl<AuthRepository>()),
    ),
  );

  // Tasks
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSource(sl<http.Client>()),
  );
  // Singleton: o repositório guarda a lista em memória.
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(sl<TaskRemoteDataSource>()),
  );
  sl.registerFactory<TasksViewModel>(
    () => TasksViewModel(
      getTasks: GetTasks(sl<TaskRepository>()),
      addTask: AddTask(sl<TaskRepository>()),
      toggleTask: ToggleTask(sl<TaskRepository>()),
    ),
  );

  // Weather
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSource(sl<http.Client>()),
  );
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(sl<WeatherRemoteDataSource>()),
  );
  sl.registerFactory<WeatherViewModel>(
    () => WeatherViewModel(GetCurrentWeather(sl<WeatherRepository>())),
  );
}
