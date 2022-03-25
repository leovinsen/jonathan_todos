import 'dart:async';

import '../model/todo.dart';

/// Responsible for adding, editing, and deleting todos
///
/// Listen to [streamCtrlTodo] to receive updates
abstract class ITaskCreator {
  final streamCtrlTodo = StreamController<List<Todo>>.broadcast();

  /// Adds a Todo
  Future<void> addTodo(Todo todo);

  /// Edits [oldTodo] into [newTodo]
  Future<void> editTodo(Todo oldTodo, Todo newTodo);

  /// Deletes a Todo
  Future<void> deleteTodo(Todo todo);

  /// Release resources
  void dispose() {
    streamCtrlTodo.close();
  }
}
