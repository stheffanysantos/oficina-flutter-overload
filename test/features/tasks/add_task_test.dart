import 'package:flutter_test/flutter_test.dart';
import 'package:rotina/core/failure.dart';
import 'package:rotina/features/tasks/domain/usecases/add_task.dart';

import '../../fakes.dart';

void main() {
  late FakeTaskRepository repo;
  late AddTask addTask;

  setUp(() {
    repo = FakeTaskRepository();
    addTask = AddTask(repo);
  });

  test('rejeita título vazio', () async {
    await expectLater(addTask('   '), throwsA(isA<Failure>()));
    expect(repo.tasks, isEmpty);
  });

  test('rejeita título maior que 80 caracteres', () async {
    await expectLater(addTask('a' * 81), throwsA(isA<Failure>()));
  });

  test('remove espaços nas pontas do título', () async {
    final task = await addTask('  Estudar Flutter  ');
    expect(task.title, 'Estudar Flutter');
  });
}
