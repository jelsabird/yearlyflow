import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';

class DateTextField extends StatefulWidget {
  const DateTextField({
    Key? key,
  this.onChanged}) : super(key: key);

  final ValueChanged<DateTime>? onChanged;

  @override
  State<StatefulWidget> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');

    return Scaffold(
      body: Center(
          child: TextField(
        readOnly: true,
        controller: _dateController,
        decoration: const InputDecoration(
          hintText: Strings.birthday_date,
        ),
        onTap: () async {
          final DateTime? date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now());
          if (date != null) {
            _dateController.text = formatter.format(date);
            if (widget.onChanged != null){
              widget.onChanged!(date);
            }
          }
        },
      )),
    );
  }
}
