import 'package:flutter/material.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/widgets/widgets.dart';

class MonthSelector extends StatefulWidget {
  final InspirationModel inspiration;
  final bool isEditable;

  const MonthSelector(
      {Key? key, required this.inspiration, this.isEditable = true})
      : super(key: key);

  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          Strings.editMonthAndTime,
          style: TextStyle(color: AppColorScheme.backgroundDarkForeground),
        ),
        widget.isEditable
            ? TimeOfMonthDropdownButton(
                value: widget.inspiration.timeOfMonth,
                onChanged: (TimeOfMonth? newValue) => setState(() {
                      widget.inspiration.timeOfMonth = newValue!;
                    }))
            : Text(
                widget.inspiration.timeOfMonth.displayString,
                style:
                    TextStyle(color: AppColorScheme.backgroundDarkForeground),
              ),
        widget.isEditable
            ? MonthDropdownButton(
                value: widget.inspiration.month,
                onChanged: (Month? newValue) => setState(() {
                      widget.inspiration.month = newValue!;
                    }))
            : Text(' ' +
                widget.inspiration.month.displayTitle.toLowerCase(),
                style:
                    TextStyle(color: AppColorScheme.backgroundDarkForeground),
              ),
      ],
    );
  }
}
