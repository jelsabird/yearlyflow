import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/birthday.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/domain/src/entity/inspiration_content.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/domain/src/entity/recipe.dart';
import 'package:yearly_flow/domain/src/util/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/presentation/src/widgets/birthday_card_content.dart';
import 'package:yearly_flow/presentation/src/widgets/bullet_list_card_content.dart';
import 'package:yearly_flow/presentation/src/widgets/note_card_content.dart';
import 'package:yearly_flow/presentation/src/widgets/recipe_card_content.dart';

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
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            _getContent(inspiration, isEditing),
            SizedBox(height: 16,)
          ]),
        ),
      ),
    );
  }

  Widget _getContent(Inspiration inspiration, bool isEditing) {
    final InspirationContent? _content = inspiration.content;
    if (_content == null) {
      return SizedBox(height: 40);
    } else {
      switch (inspiration.inspirationType) {
        case InspirationType.Note:
          return NoteCardContent(
            note: _content as Note,
            isEditing: isEditing,
          );
        case InspirationType.Birthday:
          return BirthdayCardContent(
            birthday: _content as Birthday,
            isEditing: isEditing,
          );
        case InspirationType.BulletList:
          return BulletListCardContent(
            bulletList: _content as BulletList,
            isEditing: isEditing,
          );
        case InspirationType.CheckList:
          return SizedBox(
            height: 40,
            child: Text('(Not implemented)'),
          );
        case InspirationType.Recipe:
          return RecipeCardContent(
            recipe: _content as Recipe,
            isEditing: isEditing,
          );
      }
    }
  }
}
