import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/birthday.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/domain/src/entity/check_list.dart';
import 'package:yearly_flow/domain/src/entity/inspiration_content.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/domain/src/entity/recipe.dart';
import 'package:yearly_flow/domain/src/util/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/presentation/src/widgets/birthday_card_content.dart';
import 'package:yearly_flow/presentation/src/widgets/bullet_list_card_content.dart';
import 'package:yearly_flow/presentation/src/widgets/date_text_field.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/widgets/note_card_content.dart';

class CardTemplate {
  List<Widget> getTemplateList(List<Inspiration> inspirations) {
    final List<Widget> templateList = <Widget>[];
    for (int i = 0; i < inspirations.length; i++) {
      templateList.add(getTemplate(inspirations[i]));
    }
    return templateList;
  }

  Widget getTemplate(Inspiration inspiration, {bool isEditing = false}) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _getContent(inspiration, isEditing),
          ),
        ),
      ),
    );
  }

  List<Widget> _getContent(Inspiration inspiration, bool isEditing) {
    final InspirationContent? _content = inspiration.content;
    if (_content == null) {
      return <Widget>[];
    } else {
      switch (inspiration.inspirationType) {
        case InspirationType.Note:
          return <Widget>[
            NoteCardContent(
              note: _content as Note,
              isEditing: isEditing,
            )
          ];
        case InspirationType.Birthday:
          return <Widget>[
            BirthdayCardContent(
              birthday: _content as Birthday,
              isEditing: isEditing,
            )
          ];
        case InspirationType.BulletList:
          return <Widget>[
            BulletListCardContent(
              bulletList: _content as BulletList,
              isEditing:  isEditing,
            )
          ];
        case InspirationType.CheckList:
          return isEditing
              ? _getEditableCheckListContent(_content as CheckList)
              : _getCheckListContent(_content as CheckList);
        case InspirationType.Recipe:
          return isEditing
              ? _getEditableRecipeContent(_content as Recipe)
              : _getRecipeContent(_content as Recipe);
      }
    }
  }

  List<Widget> _getTextRows(List<String> textList) {
    final List<Widget> rows = <Widget>[];
    for (final String text in textList) {
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("• "), Expanded(child: Text(text))],
      ));
    }
    return rows;
  }

  List<Widget> _getCheckListContent(CheckList checkList) {
    return <Widget>[];
  }

  List<Widget> _getEditableCheckListContent(CheckList checkList) {
    return <Widget>[];
  }

  List<Widget> _getRecipeContent(Recipe recipe) {
    return <Widget>[
      Text(
        recipe.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(recipe.introduction),
      const SizedBox(
        height: 8,
      ),
      Column(children: _getTextRows(recipe.ingredients)),
      const SizedBox(
        height: 8,
      ),
      Text(recipe.instructions)
    ];
  }

  List<Widget> _getEditableRecipeContent(Recipe recipe) {
    return <Widget>[
      const TextField(
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: Strings.cardContent_title,
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      TextField(
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: Strings.recipe_introduction,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      TextField(
        minLines: 5,
        maxLines: 20,
        decoration: InputDecoration(
          hintText: Strings.recipe_ingredients,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      TextField(
        minLines: 1,
        maxLines: 20,
        decoration: InputDecoration(
          hintText: Strings.recipe_instructions,
        ),
      ),
    ];
  }
}
