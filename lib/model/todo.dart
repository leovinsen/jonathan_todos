class Todo {
  Todo({
    required this.name,
    required this.date,
    this.checked = false,
  });

  final String name;
  final DateTime date;
  bool checked;

  @override
  String toString() {
    return "$name, $date";
  }
}
