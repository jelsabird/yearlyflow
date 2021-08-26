import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yearly_flow/service_locator.dart';
import 'package:yearly_flow/src/blocs/inspiration_add_bloc.dart';
import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/enums/time_of_month.dart';
import 'package:yearly_flow/src/ui/util/event_bus_utils.dart';
import 'package:yearly_flow/src/ui/util/month_helper.dart';
import 'package:yearly_flow/src/ui/widgets/inspiration_card.dart';
import 'package:yearly_flow/src/ui/core/app_color_scheme.dart';
import 'package:yearly_flow/src/ui/core/strings.dart';
import 'package:yearly_flow/src/ui/events/birthday_date_picked_event.dart';
import 'package:yearly_flow/src/ui/widgets/month_dropdown_button.dart';
import 'package:yearly_flow/src/ui/widgets/time_of_month_dropdown_button.dart';

class InspirationAdd extends StatefulWidget {
  const InspirationAdd({Key? key}) : super(key: key);

  @override
  _InspirationAddState createState() => _InspirationAddState();
}

class _InspirationAddState extends State<InspirationAdd> {
  _InspirationAddState() : super();
  late IInspirationAddBloc _bloc;
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    _bloc = locator.get<IInspirationAddBloc>();

    _subscription = EventBusUtils.instance.on<BirthdayDatePickedEvent>()
        .listen(_updateModel);
  }

  @override
  void dispose(){
    _subscription.cancel();
    super.dispose();
  }

  void _updateModel(BirthdayDatePickedEvent event) {
    setState(() {
      _bloc.model.month = MonthHelper.getMonth(event.date);
      _bloc.model.timeOfMonth = MonthHelper.getTimeOfMonth(event.date);
    });
  }

  void _changeTo(InspirationType inspirationType) {
    setState(() {
      _bloc.changeTo(inspirationType);
    });
  }

  bool isSelectedType(InspirationType thisType) {
    return _bloc.model.inspirationType == thisType;
  }

  ButtonStyle _selectedStyle(bool isSelected) {
    if (isSelected) {
      return TextButton.styleFrom(primary: AppColorScheme.accent);
    } else {
      return TextButton.styleFrom(primary: AppColorScheme.primary);
    }
  }

  void _save() async {
    _bloc.save();

    Navigator.pop(context);
  }

  Widget _buildSelectionRow() {
    return Row(
      children: [
        Text(
          Strings.editMonthAndTime,
          style: TextStyle(color: AppColorScheme.backgroundDarkForeground),
        ),
        TimeOfMonthDropdownButton(
          value: _bloc.model.timeOfMonth,
          onChanged: (TimeOfMonth? newValue) {
            setState(() {
              _bloc.model.timeOfMonth = newValue!;
            });
          },
        ),
        MonthDropdownButton(
          value: _bloc.model.month,
          onChanged: (Month? newValue) {
            setState(() {
              _bloc.model.month = newValue!;
            });
          },
        ),
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
                  onPressed: () => _changeTo(InspirationType.Note),
                  child: Text(InspirationType.Note.displayTitle),
                  style: _selectedStyle(isSelectedType(InspirationType.Note)),
                ),
                TextButton(
                  onPressed: () => _changeTo(InspirationType.BulletList),
                  child: Text(InspirationType.BulletList.displayTitle),
                  style: _selectedStyle(
                      isSelectedType(InspirationType.BulletList)),
                ),
                TextButton(
                  onPressed: () => _changeTo(InspirationType.Recipe),
                  child: Text(InspirationType.Recipe.displayTitle),
                  style: _selectedStyle(isSelectedType(InspirationType.Recipe)),
                ),
                TextButton(
                  onPressed: () => _changeTo(InspirationType.Birthday),
                  child: Text(InspirationType.Birthday.displayTitle),
                  style:
                  _selectedStyle(isSelectedType(InspirationType.Birthday)),
                ),
              ],
            ),
            InspirationCard(_bloc.model, isEditing: true),
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
