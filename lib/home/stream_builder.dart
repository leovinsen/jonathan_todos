import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jo_todos/model/todo.dart';

class StreamBuilderPage extends StatefulWidget {
  const StreamBuilderPage({Key? key}) : super(key: key);

  @override
  State<StreamBuilderPage> createState() => _StreamBuilderPageState();
}

class _StreamBuilderPageState extends State<StreamBuilderPage> {
  List<Object?> items = [];
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
                myTodo.add(Todo(
                    name: task,
                    date: DateTime.now().toString().substring(0, 10)));
              }
              // do something
            },
          )
        ],
      ),
      body: SafeArea(
          child: Center(
        child: StreamBuilder(
          stream: TaskCreator().stream,
          builder: (context, snapshot) {
            print(myTodo);

            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  //Caranya ambil data dari instance of Todo gimana ya ?
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

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('To do List'),
          content: const TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Add your Todo'),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: const Text('Submit'))
          ],
        ),
      );
  void submit() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }
}

class TaskCreator {
  TaskCreator() {
    _controller.sink.add(myTodo);
  }
  final _controller = StreamController<List>();

  Stream<List> get stream => _controller.stream;

  dispose() {
    _controller.close();
  }
}
