import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/domain/src/entity/enums/month.dart';
import 'package:yearly_flow/domain/src/entity/enums/time_of_month.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/presentation/src/core/app_color_scheme.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/edit_card/edit_card_controller.dart';
import 'package:yearly_flow/presentation/src/widgets/inspiration_card.dart';

class EditCardPage extends StatefulWidget {
  const EditCardPage({Key? key}) : super(key: key);

  @override
  _EditCardPageState createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  late EditCardController _controller;
  late Inspiration _inspiration;

  @override
  void initState() {
    super.initState();

    _controller = EditCardController();
    _inspiration = Note();
  }

  void _save() async {
    _controller.save(_inspiration);

    Navigator.pop(context);
  }

  Widget _buildSelectionRow() {
    return Row(
      children: [
        Text(
          Strings.editMonthAndTime,
          style: TextStyle(color: AppColorScheme.backgroundDarkForeground),
        ),
        DropdownButton(
            value: _inspiration.timeOfMonth,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            dropdownColor: AppColorScheme.backgroundDark,
            style: const TextStyle(color: AppColorScheme.accent),
            underline: Container(
              height: 2,
              color: AppColorScheme.accent,
            ),
            onChanged: (TimeOfMonth? newValue) {
              setState(() {
                _inspiration.timeOfMonth = newValue!;
              });
            },
            items: TimeOfMonth.values
                .map<DropdownMenuItem<TimeOfMonth>>((TimeOfMonth time) {
              return DropdownMenuItem<TimeOfMonth>(
                value: time,
                child: Text(time.displayString),
              );
            }).toList()),
        DropdownButton(
            value: _inspiration.month,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            dropdownColor: AppColorScheme.backgroundDark,
            style: const TextStyle(color: AppColorScheme.accent),
            underline: Container(
              height: 2,
              color: AppColorScheme.accent,
            ),
            onChanged: (Month? newValue) {
              setState(() {
                _inspiration.month = newValue!;
              });
            },
            items: Month.values.map<DropdownMenuItem<Month>>((Month month) {
              return DropdownMenuItem<Month>(
                value: month,
                child: Text(month.displayTitle.toLowerCase()),
              );
            }).toList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _inspiration = ModalRoute.of(context)!.settings.arguments as Inspiration;

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
              InspirationCard(_inspiration, isEditing: true),
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
