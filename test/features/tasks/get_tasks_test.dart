import 'package:flutter_test/flutter_test.dart';
import 'package:rotina/features/tasks/domain/entities/task.dart';
import 'package:rotina/features/tasks/domain/usecases/get_tasks.dart';

import '../../fakes.dart';

void main() {
  test('pendentes vêm antes das concluídas', () async {
    final repo = FakeTaskRepository(const [
      Task(id: '1', title: 'Estudar', done: true),
      Task(id: '2', title: 'Treinar'),
      Task(id: '3', title: 'Ler', done: true),
      Task(id: '4', title: 'Cozinhar'),
    ]);

    final result = await GetTasks(repo)();

    expect(result.map((t) => t.title), ['Treinar', 'Cozinhar', 'Estudar', 'Ler']);
  });
}
