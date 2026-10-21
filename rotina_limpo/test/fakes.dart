import 'package:rotina_limpo/features/auth/domain/entities/app_user.dart';
import 'package:rotina_limpo/features/auth/domain/repositories/auth_repository.dart';
import 'package:rotina_limpo/features/tasks/domain/entities/task.dart';
import 'package:rotina_limpo/features/tasks/domain/repositories/task_repository.dart';

/// Repositório falso: mostra como a arquitetura facilita os testes.
class FakeTaskRepository implements TaskRepository {
  FakeTaskRepository([List<Task> initial = const []]) : tasks = [...initial];

  List<Task> tasks;

  /// Quando preenchido, os métodos lançam esse erro.
  Object? error;

  @override
  Future<List<Task>> getTasks() async {
    if (error != null) throw error!;
    return List.of(tasks);
  }

  @override
  Future<Task> addTask(String title) async {
    final task = Task(id: '${tasks.length + 1}', title: title);
    tasks = [task, ...tasks];
    return task;
  }

  @override
  Future<void> toggleTask(String id) async {
    tasks = [
      for (final t in tasks) t.id == id ? t.copyWith(done: !t.done) : t,
    ];
  }
}

class FakeAuthRepository implements AuthRepository {
  AppUser? user;

  @override
  Future<AppUser> login(String email, String password) async {
    user = AppUser(email: email);
    return user!;
  }

  @override
  Future<AppUser?> currentUser() async => user;

  @override
  Future<void> logout() async {
    user = null;
  }
}
