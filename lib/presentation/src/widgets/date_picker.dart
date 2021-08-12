import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');

    return Scaffold(
      body: Center(
          child: TextField(
        readOnly: true,
        controller: dateController,
        decoration: const InputDecoration(
          hintText: 'Fødselsdag',
        ),
        onTap: () async {
          final DateTime? date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now());
          if (date != null) {
            dateController.text = formatter.format(date);
          }
        },
      )),
    );
  }
}
