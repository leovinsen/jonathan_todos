part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodoList extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo listTodo;
  const AddTodo({required this.listTodo});

  @override
  List<Object> get props => [listTodo];
}

class EditTodo extends TodoEvent {
  final Todo newTodo;
  final int index;

  const EditTodo({required this.index, required this.newTodo});

  @override
  List<Object> get props => [newTodo, index];
}

class DeleteTodo extends TodoEvent {
  final Todo listTodo;
  const DeleteTodo({required this.listTodo});

  @override
  List<Object> get props => [listTodo];
}
