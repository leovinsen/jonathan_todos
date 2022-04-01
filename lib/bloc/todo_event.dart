part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodoList extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo listTodos;
  const AddTodo({required this.listTodos});

  @override
  List<Object> get props => [listTodos];
}

class EditTodo extends TodoEvent {
  final Todo newTodos;
  final int index;
  const EditTodo({required this.index, required this.newTodos});

  @override
  List<Object> get props => [index, newTodos];
}

class DeleteTodo extends TodoEvent {
  final Todo listTodos;
  const DeleteTodo({required this.listTodos});

  @override
  List<Object> get props => [listTodos];
}
