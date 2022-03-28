import 'package:jo_todos/model/todo.dart';
import 'package:jo_todos/services/i_task_creator.dart';

/// [ITaskCreator] that uses device memory as its storage mechanism.
/// The Todos are ephemeral, which means they will be gone if app is restarted.
class MemoryTaskCreator extends ITaskCreator {
  /// Todos is saved in memory (variable)
  /// Later on we will add other storage mechanism, but for now keep it simple.
  final List<Todo> listTodos = [];

  @override
  Future<void> addTodo(Todo todo) async {
    listTodos.add(todo);
    super.streamCtrlTodo.add(listTodos);
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    listTodos.remove(todo);
    super.streamCtrlTodo.add(listTodos);
  }

  @override
  Future<void> editTodo(int index, Todo newTodo) async {
    listTodos[index].name = newTodo.name;
    super.streamCtrlTodo.add(listTodos);
    // TODO: implement editTodo
    // throw UnimplementedError();
  }
}
