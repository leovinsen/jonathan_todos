class Todo {
  Todo({
    required this.name,
    required this.date,
  });

  late String name;
  final DateTime date;

  @override
  String toString() {
    return "$name, $date";
  }
}
