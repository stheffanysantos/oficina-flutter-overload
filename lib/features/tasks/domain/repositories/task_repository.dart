import 'package:rotina/features/tasks/domain/entities/task.dart';

abstract interface class TaskRepository {
  Future<List<Task>> getTasks();
  Future<Task> addTask(String title);
  Future<void> toggleTask(String id);
}
