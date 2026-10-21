import 'package:rotina_limpo/features/tasks/domain/entities/task.dart';

/// Formato da API (JSON). Converte para a entidade do domain.
class TaskModel {
  const TaskModel({required this.id, required this.title, required this.done});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'].toString(),
        title: json['title'] as String,
        done: json['completed'] as bool,
      );

  final String id;
  final String title;
  final bool done;

  Task toEntity() => Task(id: id, title: title, done: done);
}
