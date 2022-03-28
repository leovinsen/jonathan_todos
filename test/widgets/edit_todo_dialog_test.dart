// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jo_todos/model/todo.dart';
import 'package:jo_todos/widgets/edit_or_delete_todo_dialog.dart';

void main() {
  const keyFakeButton = Key('fakeButton');

  Widget createEditTodoScreenDialog(
    Function(BuildContext) onTap,
  ) {
    return MaterialApp(
        title: 'To-Do List',
        home: Scaffold(body: Center(
          child: Builder(builder: (context) {
            return TextButton(
              key: keyFakeButton,
              onPressed: () async => await onTap(context),
              child: const Text('Edit or Remove todo'),
            );
          }),
        )));
  }

  final finderTodoTextField = find.byType(TextField);

  final todo = Todo(name: 'J0nathan', date: DateTime.now());
  final todoUpdate = Todo(name: 'Jonathan', date: todo.date);

  const taskTitleUpdate = 'Jonathan';

  group('Todo - ', () {
    testWidgets('Edit dialog', (WidgetTester tester) async {
      Future<void> onTap(BuildContext context) async {
        final result = await showDialog(
          context: context,
          builder: (_) {
            return EditOrDeleteDialog(initialTodo: todo);
          },
        ) as DialogResult?;

        expect(result?.todo.name, todoUpdate.name);
      }

      // Build our app and trigger a frame.
      await tester.pumpWidget(createEditTodoScreenDialog(onTap));

      //Show dialog
      await tester.tap(find.byKey(keyFakeButton));
      await tester.pumpAndSettle();

      //Type todo title
      await tester.enterText(finderTodoTextField, taskTitleUpdate);
      await tester.pumpAndSettle();

      await tester.tap(find.text('EDIT'));

      expect(find.text(taskTitleUpdate), findsOneWidget);
    });
  });
}
