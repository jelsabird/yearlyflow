import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:yearly_flow/src/blocs/blocs.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/widgets/inspiration_card.dart';
import 'package:yearly_flow/src/widgets/month_dropdown_button.dart';
import 'package:yearly_flow/src/widgets/time_of_month_dropdown_button.dart';

typedef OnSaveCallback = Function(InspirationModel inspiration);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final InspirationModel? inspiration;

  AddEditScreen(
      {Key? key,
      required this.isEditing,
      required this.onSave,
      this.inspiration})
      : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  bool get isEditing => widget.isEditing;
  Uuid _uuid = Uuid();

  void _changeTo(InspirationModel inspiration, InspirationType selectedType) {
    switch (selectedType) {
      case InspirationType.Note:
        inspiration = NoteModel(key: _uuid.v4());
        break;
      case InspirationType.BulletList:
        inspiration = BulletListModel(key: _uuid.v4());
        break;
      case InspirationType.Recipe:
        inspiration = RecipeModel(key: _uuid.v4());
        break;
      case InspirationType.Birthday:
        inspiration = BirthdayModel(key: _uuid.v4());
        break;
    }
  }

  ButtonStyle _selectedStyle(
      InspirationModel inspiration, InspirationType selectedType) {
    if (inspiration.inspirationType == selectedType) {
      return TextButton.styleFrom(primary: AppColorScheme.accent);
    } else {
      return TextButton.styleFrom(primary: AppColorScheme.primary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InspirationsBloc, InspirationsState>(
        builder: (context, state) {
      final inspiration = widget.inspiration ?? NoteModel(key: _uuid.v4());
      return Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.pageTitle_editCard,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                isEditing
                    ? Container()
                    : ButtonBar(
                        children: <Widget>[
                          TextButton(
                            onPressed: () =>
                                _changeTo(inspiration, InspirationType.Note),
                            child: Text(InspirationType.Note.displayTitle),
                            style: _selectedStyle(
                                inspiration, InspirationType.Note),
                          ),
                          TextButton(
                            onPressed: () => _changeTo(
                                inspiration, InspirationType.BulletList),
                            child:
                                Text(InspirationType.BulletList.displayTitle),
                            style: _selectedStyle(
                                inspiration, InspirationType.BulletList),
                          ),
                          TextButton(
                            onPressed: () =>
                                _changeTo(inspiration, InspirationType.Recipe),
                            child: Text(InspirationType.Recipe.displayTitle),
                            style: _selectedStyle(
                                inspiration, InspirationType.Recipe),
                          ),
                          TextButton(
                            onPressed: () => _changeTo(
                                inspiration, InspirationType.Birthday),
                            child: Text(InspirationType.Birthday.displayTitle),
                            style: _selectedStyle(
                                inspiration, InspirationType.Birthday),
                          ),
                        ],
                      ),
                InspirationCard(inspiration: inspiration, isEditing: true),
                Row(
                  children: [
                    Text(
                      Strings.editMonthAndTime,
                      style: TextStyle(
                          color: AppColorScheme.backgroundDarkForeground),
                    ),
                    TimeOfMonthDropdownButton(
                        value: inspiration.timeOfMonth,
                        onChanged: (TimeOfMonth? newValue) =>
                            inspiration.timeOfMonth = newValue!),
                    MonthDropdownButton(
                        value: inspiration.month,
                        onChanged: (Month? newValue) =>
                            inspiration.month = newValue!),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            widget.onSave(inspiration);
            Navigator.pop(context);
          },
          child: const Icon(Icons.check),
        ),
      );
    });
  }
}
