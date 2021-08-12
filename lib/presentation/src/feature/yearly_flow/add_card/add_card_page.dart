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
import 'package:yearly_flow/presentation/src/widgets/card_template.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';

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

  @override
  Widget build(BuildContext context) {
    inspiration.month = ModalRoute.of(context)!.settings.arguments as Month;
    final CardTemplate cardTemplate = CardTemplate();

    return Scaffold(
        backgroundColor: const Color(0xFF303030),
        appBar: AppBar(
          title: Text(Strings.addCard_pageTitle,
            style: const TextStyle(color: Colors.white, height: 40),
          ),
        ),
        body: Column(
          children: <Widget>[
            const Text(
              Strings.selectInspirationType,
              style: TextStyle(color: Colors.white),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  onPressed: () =>
                      _setInspirationType(InspirationType.Note, Note()),
                  child: Text(InspirationType.Note.displayTitle,
                      style: _getSelectedTypeStyle(InspirationType.Note)),
                ),
                TextButton(
                  onPressed: () => _setInspirationType(
                      InspirationType.BulletList, BulletList('', <String>[])),
                  child: Text(InspirationType.BulletList.displayTitle,
                      style: _getSelectedTypeStyle(InspirationType.BulletList)),
                ),
                TextButton(
                  onPressed: () => _setInspirationType(
                      InspirationType.CheckList, CheckList()),
                  child: Text(InspirationType.CheckList.displayTitle,
                      style: _getSelectedTypeStyle(InspirationType.CheckList)),
                ),
                TextButton(
                  onPressed: () => _setInspirationType(
                      InspirationType.Recipe, Recipe('', <String>[], '')),
                  child: Text(InspirationType.Recipe.displayTitle,
                      style: _getSelectedTypeStyle(InspirationType.Recipe)),
                ),
                TextButton(
                  onPressed: () => _setInspirationType(
                      InspirationType.Birthday, Birthday('', DateTime.now())),
                  child: Text(InspirationType.Birthday.displayTitle,
                      style: _getSelectedTypeStyle(InspirationType.Birthday)),
                ),
              ],
            ),
            cardTemplate.getTemplate(inspiration, editable: true),
            const Text(
              Strings.selectTimeOfMonth,
              style: TextStyle(color: Colors.white),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  onPressed: () => _setTimeOfMonth(TimeOfMonth.Any),
                  child: Text(
                    TimeOfMonth.Any.displayTitle,
                    style: _getSelectedTimeStyle(TimeOfMonth.Any),
                  ),
                ),
                TextButton(
                  onPressed: () => _setTimeOfMonth(TimeOfMonth.Start),
                  child: Text(
                    TimeOfMonth.Start.displayTitle,
                    style: _getSelectedTimeStyle(TimeOfMonth.Start),
                  ),
                ),
                TextButton(
                  onPressed: () => _setTimeOfMonth(TimeOfMonth.Middle),
                  child: Text(
                    TimeOfMonth.Middle.displayTitle,
                    style: _getSelectedTimeStyle(TimeOfMonth.Middle),
                  ),
                ),
                TextButton(
                  onPressed: () => _setTimeOfMonth(TimeOfMonth.End),
                  child: Text(
                    TimeOfMonth.End.displayTitle,
                    style: _getSelectedTimeStyle(TimeOfMonth.End),
                  ),
                )
              ],
            )
          ],
        ));
  }

  void _setInspirationType(
      InspirationType newType, InspirationContent newContent) {
    setState(() {
      inspiration.inspirationType = newType;
      inspiration.content = newContent;
    });
  }

  TextStyle? _getSelectedTypeStyle(InspirationType thisType) {
    if (inspiration.inspirationType == thisType) {
      return const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    } else {
      return null;
    }
  }

  TextStyle? _getSelectedTimeStyle(TimeOfMonth thisTime) {
    if (inspiration.timeOfMonth == thisTime) {
      return const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    } else {
      return null;
    }
  }

  void _setTimeOfMonth(TimeOfMonth newTimeOfMonth) {
    setState(() {
      inspiration.timeOfMonth = newTimeOfMonth;
    });
  }
}
