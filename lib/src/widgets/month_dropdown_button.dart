import 'package:flutter/material.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/core/core.dart';

class MonthDropdownButton extends StatefulWidget{
  const MonthDropdownButton({
    Key? key,
    this.value,
    this.onChanged,
}) : super(key: key);

  final Month? value;
  final ValueChanged<Month?>? onChanged;

  @override
  _MonthDropdownButtonState createState() => _MonthDropdownButtonState();
}

class _MonthDropdownButtonState extends State<MonthDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: widget.value,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        dropdownColor: AppColorScheme.backgroundDark,
        style: const TextStyle(color: AppColorScheme.accent),
        underline: Container(
          height: 2,
          color: AppColorScheme.accent,
        ),
        onChanged: widget.onChanged,
        items: Month.values.map<DropdownMenuItem<Month>>((Month month) {
          return DropdownMenuItem<Month>(
            value: month,
            child: Text(month.displayTitle.toLowerCase()),
          );
        }).toList());
  }
}