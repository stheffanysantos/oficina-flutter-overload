import 'package:rotina/core/failure.dart';
import 'package:rotina/features/tasks/domain/entities/task.dart';
import 'package:rotina/features/tasks/domain/repositories/task_repository.dart';

class AddTask {
  AddTask(this._repository);

  final TaskRepository _repository;

  static const maxTitleLength = 200;

  /// A mesma validação que estava na tela (ajustada na etapa 2).
  Future<Task> call(String title) async {
    final clean = title.trim();
    if (clean.isEmpty) {
      throw const Failure('Digite um título para a tarefa');
    }
    if (clean.length > maxTitleLength) {
      throw const Failure('Título muito grande');
    }
    return _repository.addTask(clean);
  }
}
