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
late TextEditingController _titleController;
late TextEditingController _introductionController;
late TextEditingController _ingredientsController;
late TextEditingController _instructionsController;

  @override
  void initState(){
    super.initState();
    _titleController = TextEditingController(text: widget.recipe.title);
    _introductionController = TextEditingController(text: widget.recipe
        .introduction);
    _ingredientsController = TextEditingController(text: BulletListHelper.convertListToText(widget.recipe
        .ingredients));
_instructionsController = TextEditingController(text: widget.recipe
    .instructions);
  }

  @override
  void dispose(){
    _titleController.dispose();
    _introductionController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _updateRecipe(
      {String? title,
      String? introduction,
      List<String>? ingredients,
      String? instructions}) {
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
            controller: _titleController,
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
            controller: _introductionController,
            onChanged: (String editedIntroduction) {
              setState(() {
                _updateRecipe(introduction: editedIntroduction);
              });
            },
            minLines: 1,
            maxLines: 20,
            style: Styles.cardBodyStyle,
            decoration: InputDecoration(
                hintText: Strings.recipe_introduction,
                hintStyle: Styles.cardBodyStyle),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: _ingredientsController,
            onChanged: (String editedIngredients) {
              setState(() {
                _updateRecipe(
                    ingredients:
                        BulletListHelper.convertTextToList(editedIngredients));
              });
            },
            minLines: 1,
            maxLines: 20,
            style: Styles.cardBodyStyle,
            decoration: InputDecoration(
                hintText: Strings.recipe_ingredients,
                hintStyle: Styles.cardBodyStyle),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: _instructionsController,
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
                hintStyle: Styles.cardBodyStyle),
          ),
        ],
      );
    } else {
      return Text(
        BulletListHelper.formatRecipe(widget.recipe.introduction,
            widget.recipe.ingredients, widget.recipe.instructions),
        overflow: TextOverflow.fade,
        style: Styles.cardBodyStyle,
      );
    }
  }
}
