import 'package:flutter/material.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({Key? key}) : super(key: key);

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('To Do List'),
      content: TextField(
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Add your Todo'),
        controller: controller,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('SUBMIT'))
      ],
    );
  }
}
