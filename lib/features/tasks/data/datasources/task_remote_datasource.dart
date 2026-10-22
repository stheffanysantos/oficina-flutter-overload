import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotina/core/env.dart';
import 'package:rotina/core/failure.dart';
import 'package:rotina/features/tasks/data/models/task_model.dart';

class TaskRemoteDataSource {
  TaskRemoteDataSource(this._client);

  final http.Client _client;

  Future<List<TaskModel>> fetchTasks() async {
    final response = await _client.get(
      // HTTPS, e a chave vem de fora do código (OWASP M1 e M5).
      Uri.https('jsonplaceholder.typicode.com', '/todos', {'_limit': '8'}),
      headers: {if (Env.apiKey.isNotEmpty) 'x-api-key': Env.apiKey},
    );
    if (response.statusCode != 200) {
      throw Failure('Erro ao buscar tarefas (${response.statusCode})');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
