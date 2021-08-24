import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/birthday.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/domain/src/entity/recipe.dart';
import 'package:yearly_flow/domain/src/entity/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/entity/enums/month.dart';
import 'package:yearly_flow/domain/src/entity/enums/time_of_month.dart';
import 'package:yearly_flow/presentation/src/core/app_color_scheme.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/add_card/add_card_controller.dart';
import 'package:yearly_flow/presentation/src/widgets/inspiration_card.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  _AddCardPageState() : super();
  late AddCardController _controller;
  late Inspiration _inspiration;
  Uuid uuid = Uuid();

  @override
  void initState() {
    super.initState();

    _controller = AddCardController();
    _inspiration = Note(key: uuid.v4());
  }

  void _setInspirationType(Inspiration newContent) {
    setState(() {
      _inspiration = newContent;
    });
  }

  bool isSelectedType(InspirationType thisType) {
    return _inspiration.inspirationType == thisType;
  }

  ButtonStyle _selectedStyle(bool isSelected) {
    if (isSelected) {
      return TextButton.styleFrom(primary: AppColorScheme.accent);
    } else {
      return TextButton.styleFrom(primary: AppColorScheme.primary);
    }
  }

  void _save() async {
    _controller.save(_inspiration);

    Navigator.pop(context);
  }

  Widget _buildSelectionRow() {
    return Row(
      children: [
        Text(
          Strings.editMonthAndTime,
          style: TextStyle(color: AppColorScheme.backgroundDarkForeground),
        ),
        DropdownButton(
            value: _inspiration.timeOfMonth,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            dropdownColor: AppColorScheme.backgroundDark,
            style: const TextStyle(color: AppColorScheme.accent),
            underline: Container(
              height: 2,
              color: AppColorScheme.accent,
            ),
            onChanged: (TimeOfMonth? newValue) {
              setState(() {
                _inspiration.timeOfMonth = newValue!;
              });
            },
            items: TimeOfMonth.values
                .map<DropdownMenuItem<TimeOfMonth>>((TimeOfMonth time) {
              return DropdownMenuItem<TimeOfMonth>(
                value: time,
                child: Text(time.displayString),
              );
            }).toList()),
        DropdownButton(
            value: _inspiration.month,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            dropdownColor: AppColorScheme.backgroundDark,
            style: const TextStyle(color: AppColorScheme.accent),
            underline: Container(
              height: 2,
              color: AppColorScheme.accent,
            ),
            onChanged: (Month? newValue) {
              setState(() {
                _inspiration.month = newValue!;
              });
            },
            items: Month.values.map<DropdownMenuItem<Month>>((Month month) {
              return DropdownMenuItem<Month>(
                value: month,
                child: Text(month.displayTitle.toLowerCase()),
              );
            }).toList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.pageTitle_addCard,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ButtonBar(
              children: <Widget>[
                TextButton(
                  onPressed: () => _setInspirationType(Note(key: uuid.v4())),
                  child: Text(InspirationType.Note.displayTitle),
                  style: _selectedStyle(isSelectedType(InspirationType.Note)),
                ),
                TextButton(
                  onPressed: () => _setInspirationType(BulletList(key:
                  UniqueKey().toString())),
                  child: Text(InspirationType.BulletList.displayTitle),
                  style: _selectedStyle(
                      isSelectedType(InspirationType.BulletList)),
                ),
                TextButton(
                  onPressed: () => _setInspirationType(Recipe(key: uuid.v4())),
                  child: Text(InspirationType.Recipe.displayTitle),
                  style: _selectedStyle(isSelectedType(InspirationType.Recipe)),
                ),
                TextButton(
                  onPressed: () => _setInspirationType(Birthday(key: uuid.v4(),
                      date:
                  DateTime.now())),
                  child: Text(InspirationType.Birthday.displayTitle),
                  style:
                      _selectedStyle(isSelectedType(InspirationType.Birthday)),
                ),
              ],
            ),
            InspirationCard(_inspiration, isEditing: true),
            _buildSelectionRow(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _save(),
        child: const Icon(Icons.check),
      ),
    );
  }
}
