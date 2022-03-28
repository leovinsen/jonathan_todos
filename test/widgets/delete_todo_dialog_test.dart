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

  Widget createDeleteTodoScreenDialog(
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

  final todo = Todo(name: 'J0nathan', date: DateTime.now());

  group('Todo - ', () {
    testWidgets('Delete dialog', (WidgetTester tester) async {
      Future<void> onTap(BuildContext context) async {
        final result = await showDialog(
          context: context,
          builder: (_) {
            return EditOrDeleteDialog(initialTodo: todo);
          },
        ) as DialogResult?;

        expect(result?.action, DialogAction.deleteTodo);
      }

      // Build our app and trigger a frame.
      await tester.pumpWidget(createDeleteTodoScreenDialog(onTap));

      await tester.tap(find.byKey(keyFakeButton));
      await tester.pumpAndSettle();

      await tester.tap(find.text('DELETE'));
      await tester.pumpAndSettle();

      expect(find.text(todo.name), findsNothing);
    });
  });
}
