import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/birthday.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/domain/src/entity/check_list.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/domain/src/entity/inspiration_content.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/domain/src/entity/recipe.dart';
import 'package:yearly_flow/domain/src/util/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/util/enums/month.dart';
import 'package:yearly_flow/domain/src/util/enums/time_of_month.dart';
import 'package:yearly_flow/presentation/src/core/app_color_scheme.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/widgets/inspiration_card.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  _AddCardPageState() : super();

  late Inspiration inspiration = Inspiration(
      InspirationType.Note, Month.January,
      content: Note(), timeOfMonth: TimeOfMonth.Any);

  @override
  void initState() {
    super.initState();
  }

  void _setInspirationType(
      InspirationType newType, InspirationContent newContent) {
    setState(() {
      inspiration.inspirationType = newType;
      inspiration.content = newContent;
    });
  }

  void _setTimeOfMonth(TimeOfMonth newTimeOfMonth) {
    setState(() {
      inspiration.timeOfMonth = newTimeOfMonth;
    });
  }

  bool isSelectedType(InspirationType thisType) {
    return inspiration.inspirationType == thisType;
  }

  bool isSelectedTime(TimeOfMonth thisTime) {
    return inspiration.timeOfMonth == thisTime;
  }

  ButtonStyle _selectedStyle(bool isSelected) {
    if (isSelected) {
      return TextButton.styleFrom(primary: AppColorScheme.accent);
    } else {
      return TextButton.styleFrom(primary: AppColorScheme.primary);
    }
  }

  @override
  Widget build(BuildContext context) {
    inspiration.month = ModalRoute.of(context)!.settings.arguments as Month;

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
            Text(
              Strings.selectTimeOfMonth,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  onPressed: () => _setTimeOfMonth(TimeOfMonth.Start),
                  child: Text(TimeOfMonth.Start.displayTitle),
                  style: _selectedStyle(isSelectedTime(TimeOfMonth.Start)),
                ),
                TextButton(
                  onPressed: () => _setTimeOfMonth(TimeOfMonth.Middle),
                  child: Text(TimeOfMonth.Middle.displayTitle),
                  style: _selectedStyle(isSelectedTime(TimeOfMonth.Middle)),
                ),
                TextButton(
                  onPressed: () => _setTimeOfMonth(TimeOfMonth.End),
                  child: Text(TimeOfMonth.End.displayTitle),
                  style: _selectedStyle(isSelectedTime(TimeOfMonth.End)),
                ),
                TextButton(
                  onPressed: () => _setTimeOfMonth(TimeOfMonth.Any),
                  child: Text(TimeOfMonth.Any.displayTitle),
                  style: _selectedStyle(isSelectedTime(TimeOfMonth.Any)),
                ),
              ],
            ),
            SizedBox(height: 16),
            const Text(
              Strings.selectInspirationType,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  onPressed: () =>
                      _setInspirationType(InspirationType.Note, Note()),
                  child: Text(InspirationType.Note.displayTitle),
                  style: _selectedStyle(isSelectedType(InspirationType.Note)),
                ),
                TextButton(
                  onPressed: () => _setInspirationType(
                      InspirationType.BulletList, BulletList('', <String>[])),
                  child: Text(InspirationType.BulletList.displayTitle),
                  style: _selectedStyle(
                      isSelectedType(InspirationType.BulletList)),
                ),
                TextButton(
                  onPressed: () => _setInspirationType(
                      InspirationType.CheckList, CheckList()),
                  child: Text(InspirationType.CheckList.displayTitle),
                  style:
                      _selectedStyle(isSelectedType(InspirationType.CheckList)),
                ),
                TextButton(
                  onPressed: () => _setInspirationType(
                      InspirationType.Recipe, Recipe('', <String>[], '')),
                  child: Text(InspirationType.Recipe.displayTitle),
                  style: _selectedStyle(isSelectedType(InspirationType.Recipe)),
                ),
                TextButton(
                  onPressed: () => _setInspirationType(
                      InspirationType.Birthday, Birthday('', DateTime.now())),
                  child: Text(InspirationType.Birthday.displayTitle),
                  style:
                      _selectedStyle(isSelectedType(InspirationType.Birthday)),
                ),
              ],
            ),
            InspirationCard(inspiration, isEditing: true),
          ],
        ),
      ),
    );
  }
}
