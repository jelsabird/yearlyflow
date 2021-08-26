import 'package:flutter/material.dart';
import 'package:yearly_flow/src/models/birthday_model.dart';
import 'package:yearly_flow/src/models/bullet_list_model.dart';
import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/models/note_model.dart';
import 'package:yearly_flow/src/models/recipe_model.dart';
import 'package:yearly_flow/src/ui/core/strings.dart';
import 'package:yearly_flow/src/ui/inspiration_edit.dart';
import 'package:yearly_flow/src/ui/widgets/birthday_card_content.dart';
import 'package:yearly_flow/src/ui/widgets/bullet_list_card_content.dart';
import 'package:yearly_flow/src/ui/widgets/inspiration_card.dart';
import 'package:yearly_flow/src/ui/widgets/note_card_content.dart';
import 'package:yearly_flow/src/ui/widgets/recipe_card_content.dart';

class InspirationDetail extends StatefulWidget {
  final InspirationModel model;
  final int index;

  const InspirationDetail({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  @override
  _InspirationDetailState createState() {
    return _InspirationDetailState(
      model: model,
      index: index,
    );
  }
}

class _InspirationDetailState extends State<InspirationDetail> {
  final InspirationModel model;
  final int index;

  _InspirationDetailState({
    required this.model,
    required this.index,
  });

  Future<void> _editCard() async {
    await Navigator.push(
      context,
      MaterialPageRoute<InspirationEdit>(
          builder: (BuildContext context) => InspirationEdit(model: model)),
    );

    setState(() {});

    return Future.value();
  }

  Widget buildContent() {
    switch (model.inspirationType) {
      case InspirationType.Note:
        return NoteCardContent(
          note: model as NoteModel,
        );
      case InspirationType.Birthday:
        return BirthdayCardContent(
          birthday: model as BirthdayModel,
        );
      case InspirationType.BulletList:
        return BulletListCardContent(
          bulletList: model as BulletListModel,
        );
      case InspirationType.Recipe:
        return RecipeCardContent(
          recipe: model as RecipeModel,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.pageTitle_viewCard),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: "${model.title} + $index",
            child: InspirationCard(model),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _editCard(),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
