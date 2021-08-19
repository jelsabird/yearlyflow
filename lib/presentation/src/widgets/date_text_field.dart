import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/core/styles.dart';

class DateTextField extends StatefulWidget {
  const DateTextField({
    Key? key,
    this.initialDate,
  this.onChanged}) : super(key: key);

  final DateTime? initialDate;
  final ValueChanged<DateTime>? onChanged;

  @override
  State<StatefulWidget> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  late TextEditingController controller;

  @override
  void initState(){
    super.initState();
    controller = TextEditingController();
    if(widget.initialDate != null){
      controller.text = formatter
          .format(widget.initialDate!);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: TextField(
        readOnly: true,
        controller: controller,
        style: Styles.cardBodyStyle,
        decoration: const InputDecoration(
          hintText: Strings.birthday_date,
        ),
        onTap: () async {
          final DateTime? date = await showDatePicker(
              context: context,
              initialDate: widget.initialDate!,
              firstDate: DateTime(1900),
              lastDate: DateTime.now());
          if (date != null) {
            controller.text = formatter.format(date);
            if (widget.onChanged != null){
              widget.onChanged!(date);
            }
          }
        },
      )),
    );
  }
}
