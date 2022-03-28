// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jo_todos/widgets/add_todo_dialog.dart';

void main() {
  const keyFakeButton = Key('fakeButton');

  Widget createAddTodoScreenDialog(
    Function(BuildContext) onTap,
  ) {
    return MaterialApp(
        title: 'To-Do List',
        home: Scaffold(body: Center(
          child: Builder(builder: (context) {
            return TextButton(
              key: keyFakeButton,
              onPressed: () async => await onTap(context),
              child: const Text('add todo'),
            );
          }),
        )));
  }

  final finderTodoTextField = find.byType(TextField);
  const taskTitle1 = 'J0nathan';

  group('Todo - ', () {
    /// By the way, I feel this is a bad way to write the test --
    /// but the idea is we wait for the Navigator.of(context).pop() is called
    /// in AddTodoDialog. Then we expect that it returns text entered in the dialog
    ///
    /// The reason is, we wrote the dialogs hoping that it can be reused in
    /// multiple pages (via popping).
    testWidgets('Add dialog', (WidgetTester tester) async {
      Future<void> onTap(BuildContext context) async {
        final result = await showDialog(
            context: context,
            builder: (_) {
              return const AddTodoDialog();
            });
        expect(result, taskTitle1);
      }

      // Build our app and trigger a frame.
      await tester.pumpWidget(createAddTodoScreenDialog(onTap));

      //Show dialog
      await tester.tap(find.byKey(keyFakeButton));
      await tester.pumpAndSettle();

      //Type todo title
      await tester.enterText(finderTodoTextField, taskTitle1);
      await tester.pumpAndSettle();

      // Tap submit button, which pops the dialog
      await tester.tap(find.text('SUBMIT'));

      expect(find.text(taskTitle1), findsOneWidget);
    });
  });
}
