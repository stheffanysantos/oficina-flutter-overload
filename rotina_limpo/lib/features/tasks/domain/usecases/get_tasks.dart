import 'package:rotina_limpo/features/tasks/domain/entities/task.dart';
import 'package:rotina_limpo/features/tasks/domain/repositories/task_repository.dart';

class GetTasks {
  GetTasks(this._repository);

  final TaskRepository _repository;

  /// Regra de negócio: tarefas pendentes aparecem antes das concluídas.
  Future<List<Task>> call() async {
    final tasks = await _repository.getTasks();
    final pending = tasks.where((t) => !t.done);
    final done = tasks.where((t) => t.done);
    return [...pending, ...done];
  }
}
