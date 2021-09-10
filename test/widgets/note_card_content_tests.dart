import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/widgets/note_card_content.dart';

void main() {
  group('Note card content', () {
    testWidgets('renders correctly in view details mode',
            (WidgetTester tester) async {
              NoteModel testModel = NoteModel(
                  title: 'Note to self',
                  text: 'Talk less, listen more');
          await tester.pumpWidget(MaterialApp(
              home: Scaffold(
                  body: NoteCardContent(note: testModel))));
          await tester.pumpAndSettle();

          expect(find.text(testModel.text), findsOneWidget);
        });

    testWidgets('renders correctly with empty model',
            (WidgetTester tester) async {
              NoteModel testModel = NoteModel();
          await tester.pumpWidget(MaterialApp(
              home: Scaffold(
                  body: NoteCardContent(note: testModel, isEditing: true))));
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          expect(find.byType(TextField), findsNWidgets(2));
          expect(find.text(Strings.cardContent_title), findsOneWidget);
          expect(find.text(Strings.cardContent_text), findsOneWidget);
        });

    testWidgets('renders correctly when model is provided',
            (WidgetTester tester) async {
              NoteModel testModel = NoteModel(
                  title: 'Note to self',
                  text: 'Talk less, listen more');
          await tester.pumpWidget(MaterialApp(
              home: Scaffold(
                  body: NoteCardContent(note: testModel, isEditing: true))));
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          expect(find.byType(TextField), findsNWidgets(2));
          expect(find.text(testModel.title), findsOneWidget);
          expect(find.text(testModel.text), findsOneWidget);
        });
  });
}
