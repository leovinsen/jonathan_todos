import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jo_todos/model/todo.dart';
import 'package:jo_todos/services/i_task_creator.dart';

class StreamBuilderPage extends StatefulWidget {
  const StreamBuilderPage({
    Key? key,
    required this.taskCreator,
  }) : super(key: key);

  final ITaskCreator taskCreator;

  @override
  State<StreamBuilderPage> createState() => _StreamBuilderPageState();
}

class _StreamBuilderPageState extends State<StreamBuilderPage> {
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
                final newTodo = Todo(
                  name: task,
                  date: DateTime.now().toString().substring(0, 10),
                );

                await widget.taskCreator.addTodo(newTodo);
              }
              // do something
            },
          )
        ],
      ),
      body: SafeArea(
          child: Center(
        child: StreamBuilder<List<Todo>>(
          stream: widget.taskCreator.streamCtrlTodo.stream,
          builder: (context, snapshot) {
            final todoList = snapshot.data;
            print(todoList);

            if (todoList == null) {
              // I don't think this will happen, but let's avoid runtime errors
              // for now. You can improve it later
              return Text('todos null');
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                // I personally like to retrieve the Todo object from list and
                // assign it into a variable at the start of itemBuilder.
                // This way you don't have to call todoList[index] many times.

                final Todo todo = todoList[index];
                return ListTile(
                  //Caranya ambil data dari instance of Todo gimana ya ?
                  title: Text(todo.toString()),
                );
              },
              itemCount: todoList.length,
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

// class TaskCreator {
//   TaskCreator() {
//     _controller.sink.add(myTodo);
//   }
//   final _controller = StreamController<List>();

//   Stream<List> get stream => _controller.stream;

//   dispose() {
//     _controller.close();
//   }
// }
