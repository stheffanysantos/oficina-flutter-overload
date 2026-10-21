import 'package:rotina_limpo/core/failure.dart';
import 'package:rotina_limpo/features/tasks/domain/entities/task.dart';
import 'package:rotina_limpo/features/tasks/domain/repositories/task_repository.dart';

class AddTask {
  AddTask(this._repository);

  final TaskRepository _repository;

  static const maxTitleLength = 80;

  /// Valida a entrada (OWASP M4) antes de chegar à camada de dados.
  Future<Task> call(String title) async {
    final clean = title.trim();
    if (clean.isEmpty) {
      throw const Failure('Digite um título para a tarefa');
    }
    if (clean.length > maxTitleLength) {
      throw const Failure('O título deve ter no máximo 80 caracteres');
    }
    return _repository.addTask(clean);
  }
}
