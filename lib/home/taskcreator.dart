import 'dart:async';

import 'package:jo_todos/model/todo.dart';

List<Todo> myTodo = [];

abstract class ITaskCreator {
  Stream<Todo> addTodo(Todo todo);
}

// class MemoryTaskCreator extends ITaskCreator {
//   @override
//   Stream<Todo> addTodo(Todo todo) {
//     myTodo.add(todo);
//     return myTodo;
//     // do the implementation here
//   }
// }

Stream<Todo> taskCreator(String nama) async* {
  if (nama != "") {
    myTodo.add(Todo(name: nama, date: DateTime.now()));
    yield Todo(name: nama, date: DateTime.now());
  }
}
