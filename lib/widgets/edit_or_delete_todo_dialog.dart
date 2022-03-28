import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jo_todos/model/todo.dart';

class DialogResult {
  final Todo todo;
  final DialogAction action;

  DialogResult({required this.todo, required this.action});
}

enum DialogAction {
  editTodo,
  deleteTodo,
}

class EditOrDeleteDialog extends StatefulWidget {
  const EditOrDeleteDialog({Key? key, required this.initialTodo})
      : super(key: key);

  @override
  State<EditOrDeleteDialog> createState() => _EditOrDeleteDialogState();

  final Todo initialTodo;
}

class _EditOrDeleteDialogState extends State<EditOrDeleteDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialTodo.name);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Or Remove'),
      content: TextField(
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Edit your Todo'),
        controller: controller,
      ),
      actions: [
        TextButton(onPressed: _submitEditTodo, child: const Text('EDIT')),
        TextButton(onPressed: _submitDeleteTodo, child: const Text('DELETE')),
      ],
    );
  }

  void _submitEditTodo() {
    final newTodo = Todo(
      name: controller.text.toString(),
      date: widget.initialTodo.date,
    );

    final DialogResult result = DialogResult(
      action: DialogAction.editTodo,
      todo: newTodo,
    );

    Navigator.of(context).pop(result);
  }

  void _submitDeleteTodo() {
    final DialogResult result = DialogResult(
      action: DialogAction.deleteTodo,
      todo: widget.initialTodo,
    );

    Navigator.of(context).pop(result);
  }
}
