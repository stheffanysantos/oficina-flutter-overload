class Task {
  const Task({required this.id, required this.title, this.done = false});

  final String id;
  final String title;
  final bool done;

  Task copyWith({bool? done}) =>
      Task(id: id, title: title, done: done ?? this.done);
}
