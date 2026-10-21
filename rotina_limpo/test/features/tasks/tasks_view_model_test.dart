import 'package:flutter_test/flutter_test.dart';
import 'package:rotina_limpo/core/failure.dart';
import 'package:rotina_limpo/features/tasks/domain/entities/task.dart';
import 'package:rotina_limpo/features/tasks/domain/usecases/add_task.dart';
import 'package:rotina_limpo/features/tasks/domain/usecases/get_tasks.dart';
import 'package:rotina_limpo/features/tasks/domain/usecases/toggle_task.dart';
import 'package:rotina_limpo/features/tasks/presentation/view_model/tasks_view_model.dart';

import '../../fakes.dart';

TasksViewModel buildViewModel(FakeTaskRepository repo) => TasksViewModel(
      getTasks: GetTasks(repo),
      addTask: AddTask(repo),
      toggleTask: ToggleTask(repo),
    );

void main() {
  test('load carrega as tarefas e termina sem erro', () async {
    final repo = FakeTaskRepository(const [Task(id: '1', title: 'Estudar')]);
    final vm = buildViewModel(repo);

    await vm.load();

    expect(vm.loading, isFalse);
    expect(vm.error, isNull);
    expect(vm.tasks.length, 1);
  });

  test('load expõe a mensagem de erro quando o repositório falha', () async {
    final repo = FakeTaskRepository()..error = const Failure('Sem conexão');
    final vm = buildViewModel(repo);

    await vm.load();

    expect(vm.error, 'Sem conexão');
    expect(vm.tasks, isEmpty);
  });

  test('add com título vazio retorna false e mostra o erro', () async {
    final vm = buildViewModel(FakeTaskRepository());

    final added = await vm.add('');

    expect(added, isFalse);
    expect(vm.error, 'Digite um título para a tarefa');
  });

  test('toggle move a tarefa concluída para o fim da lista', () async {
    final repo = FakeTaskRepository(const [
      Task(id: '1', title: 'Estudar'),
      Task(id: '2', title: 'Treinar'),
    ]);
    final vm = buildViewModel(repo);
    await vm.load();

    await vm.toggle('1');

    expect(vm.tasks.last.id, '1');
    expect(vm.tasks.last.done, isTrue);
  });
}
