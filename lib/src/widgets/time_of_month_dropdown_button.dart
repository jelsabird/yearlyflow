import 'package:flutter/material.dart';
import 'package:yearly_flow/src/models/enums/time_of_month.dart';
import 'package:yearly_flow/src/core/core.dart';

class TimeOfMonthDropdownButton extends StatefulWidget {
  const TimeOfMonthDropdownButton({
    Key? key,
    this.value,
    this.onChanged,
  }) : super(key: key);

  final TimeOfMonth? value;
  final ValueChanged<TimeOfMonth?>? onChanged;

  @override
  _TimeOfMonthDropdownButtonState createState() =>
      _TimeOfMonthDropdownButtonState();
}

class _TimeOfMonthDropdownButtonState extends State<TimeOfMonthDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: widget.value,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        dropdownColor: AppColorScheme.backgroundDark,
        style: TextStyle(color: AppColorScheme.accent),
        underline: Container(
          height: 2,
          color: AppColorScheme.accent,
        ),
        onChanged: widget.onChanged,
        items: TimeOfMonth.values
            .map<DropdownMenuItem<TimeOfMonth>>((TimeOfMonth time) {
          return DropdownMenuItem<TimeOfMonth>(
            value: time,
            child: Text(time.displayString),
          );
        }).toList());
  }
}
