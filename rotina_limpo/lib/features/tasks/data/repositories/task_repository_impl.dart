import 'package:rotina_limpo/core/failure.dart';
import 'package:rotina_limpo/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:rotina_limpo/features/tasks/domain/entities/task.dart';
import 'package:rotina_limpo/features/tasks/domain/repositories/task_repository.dart';

/// A API de teste não grava dados, então as alterações ficam em memória.
class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this._remote);

  final TaskRemoteDataSource _remote;
  List<Task>? _cache;

  @override
  Future<List<Task>> getTasks() async {
    if (_cache == null) {
      try {
        final models = await _remote.fetchTasks();
        _cache = models.map((m) => m.toEntity()).toList();
      } on Failure {
        rethrow;
      } catch (_) {
        throw const Failure('Sem conexão. Verifique sua internet.');
      }
    }
    return List.unmodifiable(_cache!);
  }

  @override
  Future<Task> addTask(String title) async {
    final current = await getTasks();
    final task = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
    );
    _cache = [task, ...current];
    return task;
  }

  @override
  Future<void> toggleTask(String id) async {
    final current = await getTasks();
    _cache = [
      for (final t in current) t.id == id ? t.copyWith(done: !t.done) : t,
    ];
  }
}
