import 'package:flutter/material.dart';
import 'package:jo_todos/model/todo.dart';
import 'package:jo_todos/services/i_task_creator.dart';
import 'package:jo_todos/widgets/add_todo_dialog.dart';
import 'package:jo_todos/widgets/edit_or_delete_todo_dialog.dart';

class StreamBuilderPage extends StatefulWidget {
  const StreamBuilderPage({
    Key? key,
    //requirednya aku lepas karena gamau jalan kalo di run/ render di emulator
    required this.taskCreator,
  }) : super(key: key);

  final ITaskCreator taskCreator;

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
      body: SafeArea(
          child: Center(
        child: StreamBuilder<List<Todo>>(
          // stream itu ngambil data yang sudah berubah atau berubah kalo ada event.
          stream: widget.taskCreator.streamCtrlTodo.stream,
          builder: (context, snapshot) {
            //Pengambilan data dari stream dalam bentuk snapshot kan ?
            final todoList = snapshot.data;

            if (todoList == null) {
              // I don't think this will happen, but let's avoid runtime errors
              // for now. You can improve it later
              return const Text('todos null');
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                // I personally like to retrieve the Todo object from list and
                // assign it into a variable at the start of itemBuilder.
                // This way you don't have to call todoList[index] many times.

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

    await widget.taskCreator.addTodo(newTodo);
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
        await widget.taskCreator.editTodo(index, result.todo);
        break;
      case DialogAction.deleteTodo:
        await widget.taskCreator.deleteTodo(result.todo);
        break;
    }
  }
}
