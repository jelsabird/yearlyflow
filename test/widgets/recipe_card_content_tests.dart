import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/util/bullet_list_helper.dart';
import 'package:yearly_flow/src/widgets/recipe_card_content.dart';

void main() {
  group('Note card content', () {
    testWidgets('renders correctly in view details mode',
        (WidgetTester tester) async {
      RecipeModel testModel = RecipeModel(
          title: 'Mozzarella egg bake',
          introduction: 'Quick, easy, filling and yummy!',
          ingredients: ['eggs', 'mozzarella', 'spinach'],
          instructions: 'Fry spinach until soft, whisk everything together '
              'and put in an oven dish with cheese on top, bake for 20 mins.');
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: RecipeCardContent(recipe: testModel, isEditing: false))));
      await tester.pumpAndSettle();

      expect(find.byKey(YearlyFlowKeys.formattedRecipe), findsOneWidget);
    });

    testWidgets('renders correctly with empty model',
        (WidgetTester tester) async {
      RecipeModel testModel = RecipeModel();
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: RecipeCardContent(recipe: testModel, isEditing: true))));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(4));
      expect(find.text(Strings.cardContent_title), findsOneWidget);
      expect(find.text(Strings.recipe_introduction), findsOneWidget);
      expect(find.text(Strings.recipe_ingredients), findsOneWidget);
      expect(find.text(Strings.recipe_instructions), findsOneWidget);
    });

    testWidgets('renders correctly when model is provided',
        (WidgetTester tester) async {
      RecipeModel testModel = RecipeModel(
          title: 'Mozzarella egg bake',
          introduction: 'Quick, easy, filling and yummy!',
          ingredients: ['eggs', 'mozzarella', 'spinach'],
          instructions: 'Fry spinach until soft, whisk everything together '
              'and put in an oven dish with cheese on top, bake for 20 mins.');
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: RecipeCardContent(recipe: testModel, isEditing: true))));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(4));
      expect(find.text(testModel.title), findsOneWidget);
      expect(find.text(testModel.introduction), findsOneWidget);
      expect(find.text(
              BulletListHelper.convertListToText(testModel.ingredients)),
          findsOneWidget);
      expect(find.text(testModel.instructions), findsOneWidget);
    });
  });
}
