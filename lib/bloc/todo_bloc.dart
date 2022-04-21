import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jo_todos/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<LoadTodoList>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const TodoLoaded(todos: <Todo>[]));
    });
    on<AddTodo>((event, emit) async {
      if (state is TodoLoaded) {
        final state = this.state as TodoLoaded;

        emit(TodoLoaded(todos: List.from(state.todos)..add(event.listTodo)));
      }
    });
    on<EditTodo>((event, emit) async {
      if (state is TodoLoaded) {
        final state = this.state as TodoLoaded;

        final newList = List<Todo>.from(state.todos);
        // newList[event.index].name = event.newTodo.name;

        final Todo newTodos =
            Todo(name: event.newTodo.name, date: event.newTodo.date);

        emit(TodoLoaded(
            todos: newList
              ..removeAt(event.index)
              ..insert(event.index, newTodos)));
      }
    });
    on<DeleteTodo>((event, emit) async {
      if (state is TodoLoaded) {
        final state = this.state as TodoLoaded;
        emit(
          TodoLoaded(todos: List.from(state.todos)..remove(event.listTodo)),
        );
      }
    });
  }
}
