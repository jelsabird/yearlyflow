import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/domain/src/util/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/util/enums/month.dart';
import 'package:yearly_flow/domain/src/util/enums/time_of_month.dart';
import 'package:yearly_flow/presentation/src/core/app_color_scheme.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/widgets/inspiration_card.dart';

class EditCardPage extends StatefulWidget {
  const EditCardPage({Key? key}) : super(key: key);

  @override
  _EditCardPageState createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  late Inspiration inspiration = Inspiration(
      InspirationType.Note, Month.January,
      content: Note(), timeOfMonth: TimeOfMonth.Any);

  TimeOfMonth timeDropdownValue = TimeOfMonth.Start;
  Month monthDropdownValue = Month.January;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSelectionRow() {
    return Row(
      children: [
        Text(
          Strings.editMonthAndTime,
          style: TextStyle(color: AppColorScheme.backgroundDarkForeground),
        ),
        DropdownButton(
            value: timeDropdownValue,
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
                timeDropdownValue = newValue!;
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
            value: monthDropdownValue,
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
                monthDropdownValue = newValue!;
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

  void _save(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    inspiration = ModalRoute.of(context)!.settings.arguments as Inspiration;

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
              InspirationCard(inspiration, isEditing: true),
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
