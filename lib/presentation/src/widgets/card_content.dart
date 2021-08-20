import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/birthday.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/domain/src/entity/recipe.dart';
import 'package:yearly_flow/domain/src/entity/enums/inspiration_type.dart';
import 'package:yearly_flow/presentation/src/core/styles.dart';

import 'recipe_card_content.dart';
import 'birthday_card_content.dart';
import 'bullet_list_card_content.dart';
import 'note_card_content.dart';

class CardContent extends StatefulWidget {
  CardContent(this.inspiration, {this.isEditing = false});

  final Inspiration inspiration;
  final bool isEditing;

  @override
  _CardContentState createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {
  Widget _buildTitle() {
    return SizedBox(
      height: 32,
      child: Text(
        widget.inspiration.getTitle,
        style: Styles.cardTitleStyle,
      ),
    );
  }

  Widget _buildContent() {
    return Flexible(
      child: _getContent(),
    );
  }

  Widget _getContent() {
    switch (widget.inspiration.inspirationType) {
      case InspirationType.Note:
        return NoteCardContent(
          note: widget.inspiration as Note,
          isEditing: widget.isEditing,
        );
      case InspirationType.Birthday:
        return BirthdayCardContent(
          birthday: widget.inspiration as Birthday,
          isEditing: widget.isEditing,
        );
      case InspirationType.BulletList:
        return BulletListCardContent(
          bulletList: widget.inspiration as BulletList,
          isEditing: widget.isEditing,
        );
      case InspirationType.Recipe:
        return RecipeCardContent(
          recipe: widget.inspiration as Recipe,
          isEditing: widget.isEditing,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.isEditing) {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildContent(),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTitle(),
            _buildContent(),
          ],
        ),
      );
    }
  }
}
