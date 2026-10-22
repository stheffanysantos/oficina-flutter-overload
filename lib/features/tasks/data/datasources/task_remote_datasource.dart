// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotina/core/failure.dart';
import 'package:rotina/features/tasks/data/models/task_model.dart';

class TaskRemoteDataSource {
  TaskRemoteDataSource(this._client);

  final http.Client _client;

  Future<List<TaskModel>> fetchTasks() async {
    final response = await _client.get(
      Uri.https('jsonplaceholder.typicode.com', '/todos', {'_limit': '8'}),
      // A chave continua escrita no código (corrigido na etapa 2).
      headers: {'x-api-key': 'ABC123-SECRETA'},
    );
    print('GET /todos -> ${response.statusCode}');
    if (response.statusCode != 200) {
      throw Failure('Erro ao buscar tarefas (${response.statusCode})');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
