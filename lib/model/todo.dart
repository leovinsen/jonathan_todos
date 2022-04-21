import 'package:equatable/equatable.dart';

class Todo extends Equatable {
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

  @override
  List<Object?> get props => [name, date];
}
