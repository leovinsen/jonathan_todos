import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jo_todos/model/todo.dart';
import 'package:jo_todos/services/i_task_creator.dart';

class StreamBuilderPage extends StatefulWidget {
  const StreamBuilderPage({
    Key? key,
    //requirednya aku lepas karena gamau jalan kalo di run/ render di emulator
    this.taskCreator,
  }) : super(key: key);

  final ITaskCreator? taskCreator; //Null safety

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
                final newTodo = Todo(
                  name: task,
                  date: DateTime.now(),
                );
                // newTodo terisi
                print("masuk ke new todo");
                print(newTodo);

                // fungsi dibawah gak jalan apa karena aku pake null safety ?
                // Mengirim data ke fungsi add milik Stream tapi kan ini harusnya ?
                await widget.taskCreator?.addTodo(newTodo);
              }
              // do something
            },
          )
        ],
      ),
      body: SafeArea(
          child: Center(
        child: StreamBuilder<List<Todo>>(
          // stream itu ngambil data yang sudah berubah atau berubah kalo ada event.
          stream: widget.taskCreator?.streamCtrlTodo.stream,
          builder: (context, snapshot) {
            //Pengambilan data dari stream dalam bentuk snapshot kan ?
            final todoList = snapshot.data;

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
