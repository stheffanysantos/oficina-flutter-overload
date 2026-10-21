import 'package:flutter/foundation.dart';
import 'package:rotina_limpo/core/failure.dart';
import 'package:rotina_limpo/features/tasks/domain/entities/task.dart';
import 'package:rotina_limpo/features/tasks/domain/usecases/add_task.dart';
import 'package:rotina_limpo/features/tasks/domain/usecases/get_tasks.dart';
import 'package:rotina_limpo/features/tasks/domain/usecases/toggle_task.dart';

class TasksViewModel extends ChangeNotifier {
  TasksViewModel({
    required GetTasks getTasks,
    required AddTask addTask,
    required ToggleTask toggleTask,
  })  : _getTasks = getTasks,
        _addTask = addTask,
        _toggleTask = toggleTask;

  final GetTasks _getTasks;
  final AddTask _addTask;
  final ToggleTask _toggleTask;

  List<Task> tasks = const [];
  bool loading = false;
  String? error;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      tasks = await _getTasks();
    } on Failure catch (e) {
      error = e.message;
    } catch (_) {
      error = 'Não foi possível carregar as tarefas';
    }
    loading = false;
    notifyListeners();
  }

  /// Retorna true quando a tarefa foi adicionada.
  Future<bool> add(String title) async {
    try {
      await _addTask(title);
      tasks = await _getTasks();
      error = null;
      notifyListeners();
      return true;
    } on Failure catch (e) {
      error = e.message;
    } catch (_) {
      error = 'Não foi possível adicionar a tarefa';
    }
    notifyListeners();
    return false;
  }

  Future<void> toggle(String id) async {
    try {
      await _toggleTask(id);
      tasks = await _getTasks();
      error = null;
    } on Failure catch (e) {
      error = e.message;
    } catch (_) {
      error = 'Não foi possível atualizar a tarefa';
    }
    notifyListeners();
  }
}
