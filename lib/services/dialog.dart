import 'package:flutter/material.dart';
import 'package:jo_todos/model/todo.dart';
import 'package:jo_todos/services/memory_task_creator.dart';

class DialogCreate extends StatefulWidget {
  const DialogCreate({Key? key}) : super(key: key);

  @override
  State<DialogCreate> createState() => _DialogCreateState();
}

class _DialogCreateState extends State<DialogCreate> {
  late TextEditingController controller;
  late TextEditingController editcontroller;

  final MemoryTaskCreator taskDialog = MemoryTaskCreator();

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
    return Container();
  }

  Future<String?> openDialog(BuildContext context) async {
    return showDialog<String>(
      ///FlutterError (This widget has been unmounted, so the State no longer has a context (and should be considered defunct).
      ///Consider canceling any active work during "dispose" or using the "mounted" getter to determine if the State is still active.)
      ///I got this Error
      ///
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('To do List'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Add your Todo'),
          controller: controller,
        ),
        actions: [
          TextButton(
              child: const Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
                controller.clear();
              }),
        ],
      ),
    );
  }

  void submit(BuildContext context) {
    Navigator.pop(context);
    controller.clear();
  }

  void openList(int index, Todo todotask, BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit or Remove"),
        content: TextField(
          decoration: const InputDecoration(hintText: 'Edit your Todo'),
          controller: editcontroller..text = todotask.name,
        ),
        actions: [
          TextButton(
              onPressed: () async {
                final newTodo = Todo(
                  name: editcontroller.text.toString(),
                  date: todotask.date,
                );
                await taskDialog.editTodo(index, newTodo);
                Navigator.of(context).pop();
              },
              child: const Text('Edit')),
          TextButton(
              onPressed: () async {
                await taskDialog.deleteTodo(todotask);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'))
        ],
      ),
    );
  }
}

class DialogHelper extends _DialogCreateState {
  @override
  Future<String?> openDialog(context) {
    super.initState();
    return super.openDialog(context);
  }

  @override
  void openList(int index, Todo todotask, context) {
    // TODO: implement openList
    super.openList(index, todotask, context);
  }
}
