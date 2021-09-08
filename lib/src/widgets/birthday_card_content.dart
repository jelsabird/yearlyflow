import 'package:flutter/material.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/models/birthday_model.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/enums/time_of_month.dart';
import 'package:yearly_flow/src/widgets/date_text_field.dart';

class BirthdayCardContent extends StatefulWidget {
  const BirthdayCardContent({
    Key? key,
    required this.birthday,
    this.isEditing = false,
    this.onDatePicked,
  }) : super(key: key);

  final BirthdayModel birthday;
  final bool isEditing;
  final Function? onDatePicked;

  BirthdayModel birthdayModel() => birthday;

  @override
  _BirthdayCardContentState createState() => _BirthdayCardContentState();
}

class _BirthdayCardContentState extends State<BirthdayCardContent> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.birthday.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditing) {
      return Column(
        children: [
          TextField(
            controller: _nameController,
            onChanged: (String editedName) {
              setState(() {
                widget.birthday.name = editedName;
              });
            },
            autofocus: true,
            style: Styles.cardTitleStyle,
            decoration: InputDecoration(
                hintText: Strings.birthday_name,
                hintStyle: Styles.cardTitleStyle),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 40,
            child: DateTextField(
              initialDate: widget.birthday.date,
              onChanged: (DateTime pickedDate) {
                setState(
                  () {
                    widget.birthday.date = pickedDate;
                    widget.birthday.month = Month.values[pickedDate.month - 1];
                    widget.birthday.timeOfMonth =
                        TimeOfMonthExtension.fromDate(pickedDate);
                  },
                );
              },
              onDatePicked: widget.onDatePicked,
            ),
          )
        ],
      );
    } else {
      return Text('');
    }
  }
}
