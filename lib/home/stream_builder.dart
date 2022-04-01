import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jo_todos/bloc/todo_bloc.dart';
import 'package:jo_todos/model/todo.dart';
import 'package:jo_todos/widgets/add_todo_dialog.dart';
import 'package:jo_todos/widgets/edit_or_delete_todo_dialog.dart';

class StreamBuilderPage extends StatefulWidget {
  const StreamBuilderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StreamBuilderPage> createState() => _StreamBuilderPageState();
}

class _StreamBuilderPageState extends State<StreamBuilderPage> {
  String todoTask = "";

  late TextEditingController controller;
  late TextEditingController editcontroller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    editcontroller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo-List Tutorial"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add_box,
              color: Colors.white,
            ),
            onPressed: _showDialogAddTodo,
          )
        ],
      ),
      body: SafeArea(child: Center(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoInitial) {
              return const CircularProgressIndicator(
                color: Colors.blue,
              );
            }
            if (state is TodoLoaded) {
              final todoList = state.todos;

              return ListView.builder(
                itemBuilder: (context, index) {
                  final Todo todo = todoList[index];
                  return ListTile(
                    title: Text(todo.name),
                    subtitle: Text(
                      todo.date.toString().substring(0, 16),
                    ),
                    onTap: () => _showDialogEditOrRemoveTodo(
                      index,
                      todo,
                    ),
                  );
                },
                itemCount: todoList.length,
              );
            } else {
              return const Text('Something went wrong!');
            }
          },
        ),
      )),
    );
  }

  Future<void> _showDialogAddTodo() async {
    final String? taskTitle = await showDialog<String>(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );

    // If user closed the dialog or entered an empty text
    if (taskTitle == null || taskTitle.isEmpty) return;

    final newTodo = Todo(
      name: taskTitle,
      date: DateTime.now(),
    );

    context.read<TodoBloc>().add(AddTodo(listTodos: newTodo));
  }

  Future<void> _showDialogEditOrRemoveTodo(
    int index,
    Todo todo,
  ) async {
    final DialogResult? result = await showDialog<DialogResult>(
      context: context,
      builder: (context) => EditOrDeleteDialog(
        initialTodo: todo,
      ),
    );

    // If user closed the dialog
    if (result == null) return;

    switch (result.action) {
      case DialogAction.editTodo:
        context
            .read<TodoBloc>()
            .add(EditTodo(index: index, newTodos: result.todo));
        break;
      case DialogAction.deleteTodo:
        context.read<TodoBloc>().add(DeleteTodo(listTodos: result.todo));

        break;
    }
  }
}
