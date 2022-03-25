import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jo_todos/home/taskcreator.dart';

class StreamBuilderPage extends StatefulWidget {
  const StreamBuilderPage({Key? key}) : super(key: key);

  @override
  State<StreamBuilderPage> createState() => _StreamBuilderPageState();
}

class _StreamBuilderPageState extends State<StreamBuilderPage> {
  String todoTask = "";
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo-List Tutorial"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.plus_one,
              color: Colors.white,
            ),
            onPressed: () async {
              final task = await openDialog();
              if (task == null) {
                return;
              } else {
                todoTask = task;
              }
              // do something
            },
          )
        ],
      ),
      body: SafeArea(
          child: Center(
        child: StreamBuilder(
          stream: taskCreator(todoTask),
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(myTodo[index].toString()),
                );
              },
              itemCount: myTodo.length,
            );
          },
        ),
      )),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
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
              onPressed: submit,
            )
          ],
        ),
      );
  void submit() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }
}
