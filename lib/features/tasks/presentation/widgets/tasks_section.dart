import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rotina/features/tasks/presentation/view_model/tasks_view_model.dart';

class TasksSection extends StatefulWidget {
  const TasksSection({super.key});

  @override
  State<TasksSection> createState() => _TasksSectionState();
}

class _TasksSectionState extends State<TasksSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final added = await context.read<TasksViewModel>().add(_controller.text);
    if (added) _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TasksViewModel>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Nova tarefa',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _submit(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                tooltip: 'Adicionar',
                onPressed: _submit,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        if (vm.error != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              vm.error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        Expanded(
          child: vm.loading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    for (final task in vm.tasks)
                      CheckboxListTile(
                        value: task.done,
                        title: Text(
                          task.title,
                          style: task.done
                              ? const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                )
                              : null,
                        ),
                        onChanged: (_) =>
                            context.read<TasksViewModel>().toggle(task.id),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}
