import 'package:rotina/core/failure.dart';
import 'package:rotina/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:rotina/features/tasks/domain/entities/task.dart';
import 'package:rotina/features/tasks/domain/repositories/task_repository.dart';

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

  // Adicionar e alternar usam a lista em memória, sem voltar à rede:
  // assim funcionam mesmo quando a busca inicial falhou (sem internet).
  @override
  Future<Task> addTask(String title) async {
    final task = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
    );
    _cache = [task, ...?_cache];
    return task;
  }

  @override
  Future<void> toggleTask(String id) async {
    _cache = [
      for (final t in _cache ?? const <Task>[])
        t.id == id ? t.copyWith(done: !t.done) : t,
    ];
  }
}
