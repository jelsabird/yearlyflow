import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/widgets/type_selector.dart';

void main() {
  group('Type selector', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: TypeSelector(
        onSelect: (_) => null,
      ))));
      await tester.pumpAndSettle();

      expect(find.byType(TextButton), findsNWidgets(4));
      expect(find.text(InspirationType.Note.displayTitle), findsOneWidget);
      expect(
          find.text(InspirationType.BulletList.displayTitle), findsOneWidget);
      expect(find.text(InspirationType.Recipe.displayTitle), findsOneWidget);
      expect(find.text(InspirationType.Birthday.displayTitle), findsOneWidget);
    });

    testWidgets('should call onSelect with note model when note button is '
        'pressed',
        (WidgetTester tester) async {
      var isNoteModel = false;
      await tester.pumpWidget(
          MaterialApp(
              home: Scaffold(
                  body: TypeSelector(
        onSelect: (selectedModel) {
          isNoteModel = selectedModel is NoteModel;
        },
      ))));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(TextButton).at(0));

      expect(isNoteModel, true);
    });

    testWidgets('should call onSelect with bullet list model when bullet list '
        'button is pressed',
            (WidgetTester tester) async {
          var isBulletListModel = false;
          await tester.pumpWidget(
              MaterialApp(
                  home: Scaffold(
                      body: TypeSelector(
                        onSelect: (selectedModel) {
                          isBulletListModel = selectedModel is BulletListModel;
                        },
                      ))));
          await tester.pumpAndSettle();
          await tester.tap(find.byType(TextButton).at(1));

          expect(isBulletListModel, true);
        });

    testWidgets('should call onSelect with recipe model when recipe button is '
        'pressed',
            (WidgetTester tester) async {
          var isRecipeModel = false;
          await tester.pumpWidget(
              MaterialApp(
                  home: Scaffold(
                      body: TypeSelector(
                        onSelect: (selectedModel) {
                          isRecipeModel = selectedModel is RecipeModel;
                        },
                      ))));
          await tester.pumpAndSettle();
          await tester.tap(find.byType(TextButton).at(2));

          expect(isRecipeModel, true);
        });

    testWidgets('should call onSelect with birthday model when birthday button '
        'is pressed',
            (WidgetTester tester) async {
          var isBirthdayModel = false;
          await tester.pumpWidget(
              MaterialApp(
                  home: Scaffold(
                      body: TypeSelector(
                        onSelect: (selectedModel) {
                          isBirthdayModel = selectedModel is BirthdayModel;
                        },
                      ))));
          await tester.pumpAndSettle();
          await tester.tap(find.byType(TextButton).at(3));

          expect(isBirthdayModel, true);
        });
  });
}
