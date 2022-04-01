import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jo_todos/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<LoadTodoList>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 3));
      emit(const TodoLoaded(todos: <Todo>[]));
    });
    on<AddTodo>((event, emit) async {
      if (state is TodoLoaded) {
        final state = this.state as TodoLoaded;

        emit(TodoLoaded(todos: List.from(state.todos)..add(event.listTodos)));
      }
    });
    on<EditTodo>((event, emit) async {
      if (state is TodoLoaded) {
        final state = this.state as TodoLoaded;
        state.todos[event.index].name = event.newTodos.name;
        final Todo updateTodo = state.todos[event.index];

        emit(TodoLoaded(
            todos: List.from(state.todos)
              ..removeAt(event.index)
              ..insert(event.index, updateTodo)));
      }
    });
    on<DeleteTodo>((event, emit) async {
      if (state is TodoLoaded) {
        final state = this.state as TodoLoaded;
        emit(
          TodoLoaded(todos: List.from(state.todos)..remove(event.listTodos)),
        );
      }
    });
  }
}
