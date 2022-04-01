import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jo_todos/bloc/todo_bloc.dart';
import 'package:jo_todos/home/stream_builder.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TodoBloc()..add(LoadTodoList()))
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To-Do List',
          home: StreamBuilderPage(),
        ));
  }
}
