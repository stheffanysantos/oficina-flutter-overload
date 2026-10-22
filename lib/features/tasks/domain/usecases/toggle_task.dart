import 'package:rotina/features/tasks/domain/repositories/task_repository.dart';

class ToggleTask {
  ToggleTask(this._repository);

  final TaskRepository _repository;

  Future<void> call(String id) => _repository.toggleTask(id);
}
