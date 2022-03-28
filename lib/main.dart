import 'package:flutter/material.dart';
import 'package:jo_todos/home/stream_builder.dart';
import 'package:jo_todos/services/memory_task_creator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root
  // of your application.

  @override
  Widget build(BuildContext context) {
    final MemoryTaskCreator taskCreator = MemoryTaskCreator();
    return MaterialApp(
      title: "To-Do List",
      home: StreamBuilderPage(
        taskCreator: taskCreator,
      ),
    );
  }
}
