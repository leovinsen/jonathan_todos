// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jo_todos/home/stream_builder.dart';
import 'package:jo_todos/services/memory_task_creator.dart';
import 'package:jo_todos/widgets/add_todo_dialog.dart';
import 'package:jo_todos/widgets/edit_or_delete_todo_dialog.dart';

void main() {
  final MemoryTaskCreator taskCreator = MemoryTaskCreator();
  Widget createTodoScreenWidget() {
    return MaterialApp(
      title: 'To-Do List',
      home: StreamBuilderPage(taskCreator: taskCreator),
    );
  }

  final finderAddToDoIcon = find.byIcon(Icons.add_box);
  final finderTodoTextField = find.byType(TextField);
  const taskTitle1 = 'J0nathan';
  group('Homepage Test - ', () {
    testWidgets('Expect visual', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(createTodoScreenWidget());

      expect(finderAddToDoIcon, findsOneWidget);
    });
    group('Show dialog - ', () {
      testWidgets('Add todo dialog', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        await tester.pumpWidget(createTodoScreenWidget());

        await tester.tap(finderAddToDoIcon);
        await tester.pumpAndSettle();

        expect(find.byType(AddTodoDialog), findsOneWidget);
      });

      testWidgets('Edit or Remove todo dialog', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        await tester.pumpWidget(createTodoScreenWidget());

        await tester.tap(finderAddToDoIcon);
        await tester.pumpAndSettle();

        await tester.enterText(finderTodoTextField, taskTitle1);
        await tester.tap(find.byType(TextButton));
        await tester.pumpAndSettle();

        await tester.tap(find.text(taskTitle1));
        await tester.pumpAndSettle();

        expect(find.byType(EditOrDeleteDialog), findsOneWidget);
      });
    });
  });
}
