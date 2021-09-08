import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/core/core.dart';

typedef OnSelectedCallBack = Function(InspirationModel inspiration);

class TypeSelector extends StatefulWidget {
  final OnSelectedCallBack onSelect;
  final InspirationType initialValue;

  const TypeSelector(
      {Key? key,
      required this.onSelect,
      this.initialValue = InspirationType.Note})
      : super(key: key);

  @override
  _TypeSelectorState createState() => _TypeSelectorState();
}

class _TypeSelectorState extends State<TypeSelector> {
  Uuid _uuid = Uuid();
  late InspirationType selectedType = widget.initialValue;

  ButtonStyle _selectedStyle(InspirationType thisType) {
    if (selectedType == thisType) {
      return TextButton.styleFrom(primary: AppColorScheme.accent);
    } else {
      return TextButton.styleFrom(primary: AppColorScheme.primary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        TextButton(
          onPressed: () => setState(() {
            selectedType = InspirationType.Note;
            widget.onSelect(NoteModel(key: _uuid.v4()));
          }),
          child: Text(InspirationType.Note.displayTitle),
          style: _selectedStyle(InspirationType.Note),
        ),
        TextButton(
          onPressed: () => setState(() {
            selectedType = InspirationType.BulletList;
            widget.onSelect(BulletListModel(key: _uuid.v4()));
          }),
          child: Text(InspirationType.BulletList.displayTitle),
          style: _selectedStyle(InspirationType.BulletList),
        ),
        TextButton(
          onPressed: () => setState(() {
            selectedType = InspirationType.Recipe;
            widget.onSelect(RecipeModel(key: _uuid.v4()));
          }),
          child: Text(InspirationType.Recipe.displayTitle),
          style: _selectedStyle(InspirationType.Recipe),
        ),
        TextButton(
          onPressed: () => setState(() {
            selectedType = InspirationType.Birthday;
            widget.onSelect(BirthdayModel(key: _uuid.v4()));
          }),
          child: Text(InspirationType.Birthday.displayTitle),
          style: _selectedStyle(InspirationType.Birthday),
        ),
      ],
    );
  }
}
