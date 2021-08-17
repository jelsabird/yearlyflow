import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/recipe.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/core/styles.dart';
import 'package:yearly_flow/presentation/src/util/bullet_list_helper.dart';

class RecipeCardContent extends StatefulWidget {
  const RecipeCardContent({
    Key? key,
    required this.recipe,
    this.isEditing = false,
  }) : super(key: key);

  final Recipe recipe;
  final bool isEditing;

  @override
  _RecipeCardContentState createState() => _RecipeCardContentState();
}

class _RecipeCardContentState extends State<RecipeCardContent> {
  void _updateRecipe({String? title, String? introduction, List<String>?
  ingredients, String? instructions}) {
    if (title != null) {
      widget.recipe.title = title.trim();
    }
    if (introduction != null) {
      widget.recipe.introduction = introduction;
    }
    if (ingredients != null) {
      widget.recipe.ingredients = ingredients;
    }
    if (instructions != null) {
      widget.recipe.instructions = instructions;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditing) {
      return Column(
        children: [
          TextField(
            onChanged: (String editedTitle) {
              setState(() {
                _updateRecipe(title: editedTitle);
              });
            },
            style: Styles.cardTitleStyle,
            decoration: InputDecoration(
              hintText: Strings.cardContent_title,
              hintStyle: Styles.cardTitleStyle,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            onChanged: (String editedIntroduction) {
              setState(() {
                _updateRecipe(introduction: editedIntroduction);
              });
            },
            minLines: 1,
            maxLines: 5,
            style: Styles.cardBodyStyle,
            decoration: InputDecoration(
              hintText: Strings.recipe_introduction,
              hintStyle: Styles.cardBodyStyle
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            onChanged: (String editedIngredients) {
              setState(() {
                _updateRecipe(ingredients: BulletListHelper.convertTextToList(
                    editedIngredients));
              });
            },
            minLines: 5,
            maxLines: 20,
            style: Styles.cardBodyStyle,
            decoration: InputDecoration(
              hintText: Strings.recipe_ingredients,
              hintStyle: Styles.cardBodyStyle
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            onChanged: (String editedInstructions) {
              setState(() {
                _updateRecipe(instructions: editedInstructions);
              });
            },
            minLines: 1,
            maxLines: 20,
            style: Styles.cardBodyStyle,
            decoration: InputDecoration(
              hintText: Strings.recipe_instructions,
              hintStyle: Styles.cardBodyStyle
            ),
          ),
        ],
      );
    }
    else {
      return Column(
        children: [
          Text(
            widget.recipe.title,
            style: Styles.cardTitleStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(widget.recipe.introduction, style: Styles.cardBodyStyle,),
          const SizedBox(
            height: 8,
          ),
          Column(children: BulletListHelper.getTextRows(widget.recipe
              .ingredients)),
          const SizedBox(
            height: 8,
          ),
          Text(widget.recipe.instructions, style: Styles.cardBodyStyle,),
        ],
      );
    }
  }
}