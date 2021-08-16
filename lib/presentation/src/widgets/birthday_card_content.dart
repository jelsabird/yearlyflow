import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/birthday.dart';
import 'package:yearly_flow/presentation/src/widgets/date_text_field.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';

class BirthdayCardContent extends StatefulWidget {
  const BirthdayCardContent({
    Key? key,
  required this.birthday,
    this.isEditing = false,
}) : super(key: key);

  final Birthday birthday;
  final bool isEditing;

  @override
  _BirthdayCardContentState createState() => _BirthdayCardContentState();
}

class _BirthdayCardContentState extends State<BirthdayCardContent> {
  late TextEditingController _textEditingController;
  late int age;

  @override
  void initState(){
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _updateBirthday({String? name, DateTime? date}){
    if (name != null){
      widget.birthday.name = name.trim();
    }
    if (date != null){
      widget.birthday.date = date;
      age = DateTime.now().year - widget.birthday.date.year;
    }
  }

  @override
  Widget build(BuildContext context) {

    final int age = DateTime.now().year - widget.birthday.date.year;

    if (widget.isEditing) {
      return Column(
        children: [
          Text(
            '${widget.birthday.name} fyller $age år den ${widget.birthday.date.day
                .toString()}.${widget.birthday.date.month.toString()}.',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),),
          TextField(
            onChanged: (String editedName) {
              setState(() {
                _updateBirthday(name: editedName);
              });
            },
            autofocus: true,
            decoration: InputDecoration(
              hintText: Strings.birthday_name,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 40,
            child: DateTextField(
              onChanged: (DateTime pickedDate) {
                setState(() {
                  _updateBirthday(date: pickedDate);
                });
              },
            ),
          )
        ],
      );
    }
    else {
      return Text(
        '${widget.birthday.name} fyller $age år den ${widget.birthday.date.day
            .toString()}.${widget.birthday.date.month.toString()}.',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),);
    }
  }
}