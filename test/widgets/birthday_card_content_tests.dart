import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/widgets/birthday_card_content.dart';
import 'package:yearly_flow/src/widgets/date_text_field.dart';

void main() {
  group('Birthday card content', () {
    testWidgets('renders correctly in view details mode',
        (WidgetTester tester) async {
      BirthdayModel testModel = BirthdayModel();
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body:
                  BirthdayCardContent(birthday: testModel, isEditing: false))));
      await tester.pumpAndSettle();

      expect(find.byKey(YearlyFlowKeys.emptyBirthdayContent), findsOneWidget);
    });

    testWidgets('renders correctly with empty model',
        (WidgetTester tester) async {
      BirthdayModel testModel = BirthdayModel();
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body:
                  BirthdayCardContent(birthday: testModel, isEditing: true))));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text(Strings.birthday_name), findsOneWidget);
      expect(find.byType(DateTextField), findsOneWidget);
      expect(find.text(Strings.birthday_date), findsOneWidget);
    });

    testWidgets('renders correctly when model is provided',
        (WidgetTester tester) async {
      BirthdayModel testModel = BirthdayModel(
          name: 'Molly',
          date: DateTime(2010, 2, 3),
          month: Month.February,
          timeOfMonth: TimeOfMonth.Start);
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body:
                  BirthdayCardContent(birthday: testModel, isEditing: true))));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text(testModel.name), findsOneWidget);
      expect(find.byType(DateTextField), findsOneWidget);
      expect(find.text(DateFormat('dd.MM.yyyy').format(testModel.date!)),
          findsOneWidget);
    });
  });
}
