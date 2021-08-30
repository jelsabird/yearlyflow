import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yearly_flow/service_locator.dart';
import 'package:yearly_flow/src/blocs/inspiration_edit_bloc.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/enums/time_of_month.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/util/event_bus_utils.dart';
import 'package:yearly_flow/src/ui/util/month_helper.dart';
import 'package:yearly_flow/src/ui/widgets/inspiration_card.dart';
import 'package:yearly_flow/src/ui/core/app_color_scheme.dart';
import 'package:yearly_flow/src/ui/core/strings.dart';
import 'package:yearly_flow/src/ui/events/birthday_date_picked_event.dart';
import 'package:yearly_flow/src/ui/widgets/month_dropdown_button.dart';
import 'package:yearly_flow/src/ui/widgets/time_of_month_dropdown_button.dart';

class InspirationEdit extends StatefulWidget {
  final InspirationModel model;

  const InspirationEdit({Key? key, required this.model}) : super(key: key);

  @override
  _InspirationEditState createState() => _InspirationEditState(model);
}

class _InspirationEditState extends State<InspirationEdit> {
  final InspirationModel _model;
  late IInspirationEditBloc _bloc;
  late StreamSubscription _subscription;

  _InspirationEditState(this._model);

  @override
  void initState() {
    super.initState();

    _bloc = locator.get<IInspirationEditBloc>(param1: _model);

    _subscription =
        EventBusUtils.instance.on<BirthdayDatePickedEvent>().listen((event) {
      _updateModel(event.date);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _updateModel(DateTime date) {
    setState(() {
      _bloc.model
        ..month = MonthHelper.getMonth(date)
        ..timeOfMonth = MonthHelper.getTimeOfMonth(date);
    });
  }

  void _save() {
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
          Strings.pageTitle_editCard,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InspirationCard(_bloc.model, isEditing: true),
              _buildSelectionRow(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _save(),
        child: const Icon(Icons.check),
      ),
    );
  }
}
