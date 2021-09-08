import 'package:flutter/material.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/core/styles.dart';

import 'recipe_card_content.dart';
import 'birthday_card_content.dart';
import 'bullet_list_card_content.dart';
import '../widgets/note_card_content.dart';

class CardContent extends StatefulWidget {
  CardContent({required this.inspiration, this.isEditing = false});

  final InspirationModel inspiration;
  final bool isEditing;

  @override
  _CardContentState createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {
  Widget _buildTitle() {
    return SizedBox(
      height: 32,
      child: Text(
        widget.inspiration.title,
        style: Styles.cardTitleStyle,
      ),
    );
  }

  Widget _buildContent() {
    return Flexible(
      fit: FlexFit.loose,
      child: _getContent(),
    );
  }

  Widget _getContent() {
    switch (widget.inspiration.inspirationType) {
      case InspirationType.Note:
        return NoteCardContent(
          note: widget.inspiration as NoteModel,
          isEditing: widget.isEditing,
        );
      case InspirationType.BulletList:
        return BulletListCardContent(
          bulletList: widget.inspiration as BulletListModel,
          isEditing: widget.isEditing,
        );
      case InspirationType.Recipe:
        return RecipeCardContent(
          recipe: widget.inspiration as RecipeModel,
          isEditing: widget.isEditing,
        );
      case InspirationType.Birthday:
        return BirthdayCardContent(
          birthday: widget.inspiration as BirthdayModel,
          isEditing: widget.isEditing,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!this.widget.isEditing) _buildTitle(),
          _buildContent(),
        ],
      ),
    );
  }
}
