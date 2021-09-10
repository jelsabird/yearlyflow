import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/util/bullet_list_helper.dart';
import 'package:yearly_flow/src/widgets/bullet_list_card_content.dart';

void main() {
  group('Bullet list card content', () {
    testWidgets('renders correctly in view details mode',
        (WidgetTester tester) async {
          BulletListModel testModel = BulletListModel(
              title: 'To do',
              bulletPoints: ['pack', 'clean', 'empty garbage', 'water plants']);
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: BulletListCardContent(
                  bulletList: testModel, isEditing: false))));
      await tester.pumpAndSettle();

      expect(find.byKey(YearlyFlowKeys.formattedBulletList), findsOneWidget);
    });

    testWidgets('renders correctly with empty model',
        (WidgetTester tester) async {
      BulletListModel testModel = BulletListModel();
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: BulletListCardContent(
                  bulletList: testModel, isEditing: true))));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text(Strings.cardContent_title), findsOneWidget);
      expect(find.text(Strings.inspirationType_bulletList), findsOneWidget);
    });

    testWidgets('renders correctly when model is provided',
        (WidgetTester tester) async {
      BulletListModel testModel = BulletListModel(
          title: 'To do',
          bulletPoints: ['pack', 'clean', 'empty garbage', 'water plants']);
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: BulletListCardContent(
                  bulletList: testModel, isEditing: true))));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text(testModel.title), findsOneWidget);
      expect(find.text(BulletListHelper.formatStringFromList(testModel
          .bulletPoints)), findsOneWidget);
    });
  });
}
