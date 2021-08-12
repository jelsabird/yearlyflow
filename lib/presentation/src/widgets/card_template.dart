import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/birthday.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/domain/src/entity/check_list.dart';
import 'package:yearly_flow/domain/src/entity/inspiration_content.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/domain/src/entity/recipe.dart';
import 'package:yearly_flow/domain/src/util/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/presentation/src/widgets/date_picker.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';

class CardTemplate {
  List<Widget> getTemplateList(List<Inspiration> inspirations) {
    final List<Widget> templateList = <Widget>[];
    for (int i = 0; i < inspirations.length; i++) {
      templateList.add(getTemplate(inspirations[i]));
    }
    return templateList;
  }

  Widget getTemplate(Inspiration inspiration, {bool editable = false}) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _getContent(inspiration, editable),
          ),
        ),
      ),
    );
  }

  List<Widget> _getContent(Inspiration inspiration, bool editable) {
    final InspirationContent? _content = inspiration.content;
    if (_content == null) {
      return <Widget>[];
    } else {
      switch (inspiration.inspirationType) {
        case InspirationType.Note:
          return editable
              ? _getEditableNoteContent(_content as Note)
              : _getNoteContent(_content as Note);
        case InspirationType.Birthday:
          return editable
              ? _getEditableBirthdayContent(_content as Birthday)
              : _getBirthdayContent(_content as Birthday);
        case InspirationType.BulletList:
          return editable
              ? _getEditableBulletListContent(_content as BulletList)
              : _getBulletListContent(_content as BulletList);
        case InspirationType.CheckList:
          return editable
              ? _getEditableCheckListContent(_content as CheckList)
              : _getCheckListContent(_content as CheckList);
        case InspirationType.Recipe:
          return editable
              ? _getEditableRecipeContent(_content as Recipe)
              : _getRecipeContent(_content as Recipe);
      }
    }
  }

  List<Widget> _getNoteContent(Note note) {
    return <Widget>[
      Text(
        note.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(note.text),
    ];
  }

  List<Widget> _getEditableNoteContent(Note note) {
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
        decoration: InputDecoration(
          hintText: Strings.cardContent_text,
        ),
      ),
    ];
  }

  List<Widget> _getBirthdayContent(Birthday birthday) {
    final int age = DateTime.now().year - birthday.date.year;
    return <Widget>[
      Text(
        '${birthday.name} fyller $age år den ${birthday.date.day.toString()}.${birthday.date.month.toString()}.',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
  }

  List<Widget> _getEditableBirthdayContent(Birthday birthday) {

    return <Widget>[
      const TextField(
        decoration: InputDecoration(
          hintText: Strings.birthday_name,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      const SizedBox(
        height: 400,
        child: DatePicker(),
      )
    ];
  }

  List<Widget> _getBulletListContent(BulletList bulletList) {
    return <Widget>[
      Text(
        bulletList.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Column(children: _getTextRows(bulletList.bulletPoints)),
    ];
  }

  List<Widget> _getEditableBulletListContent(BulletList bulletList) {
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
        minLines: 5,
        maxLines: 20,
        decoration: InputDecoration(
          hintText: Strings.inspirationType_bulletList,
        ),
      ),
    ];
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
