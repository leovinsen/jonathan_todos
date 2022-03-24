class Todo {
  Todo({required this.name, required this.date, this.checked = false});
  final String name;
  final String date;
  bool checked;
}

List<Todo> myTodo = [];
