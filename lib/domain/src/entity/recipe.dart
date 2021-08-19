import 'package:yearly_flow/domain/src/util/parser.dart';

import 'inspiration_content.dart';

class Recipe implements InspirationContent {
  Recipe(this.title, this.ingredients, this.instructions,
      {this.introduction = ''});

  @override
  factory Recipe.fromJson(Map<String, dynamic> json) {
    final String? parsedTitle = Parser.getString(json, 'title');
    final String? parsedIntroduction = Parser.getString(json, 'introduction');
    final List<String> parsedIngredients =
        List<String>.from(Parser.getList(json, 'ingredients'));
    final String? parsedInstructions = Parser.getString(json, 'instructions');

    return Recipe(
        parsedTitle ?? '', parsedIngredients, parsedInstructions ?? '',
        introduction: parsedIntroduction ?? '');
  }

  String getTitle() => title;

  String title = '';
  String introduction = '';
  List<String> ingredients = <String>[];
  String instructions = '';
}
