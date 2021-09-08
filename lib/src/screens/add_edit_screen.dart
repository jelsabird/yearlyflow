import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:yearly_flow/src/blocs/blocs.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/widgets/inspiration_card.dart';
import 'package:yearly_flow/src/widgets/month_dropdown_button.dart';
import 'package:yearly_flow/src/widgets/time_of_month_dropdown_button.dart';
import 'package:yearly_flow/src/widgets/type_selector.dart';

typedef OnSaveCallback = Function(InspirationModel inspiration);

class AddEditScreen extends StatefulWidget {
  final OnSaveCallback onSave;
  final InspirationModel? inspiration;

  AddEditScreen({Key? key, required this.onSave, this.inspiration})
      : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late InspirationModel _inspiration;

  bool get _isEditing => widget.inspiration != null;
  final InspirationType _defaultType = InspirationType.Note;
  late Month _month;
  late TimeOfMonth _timeOfMonth;
  Uuid _uuid = Uuid();

  @override
  void initState() {
    super.initState();

    if (_isEditing) {
      _inspiration = InspirationModel.copyWith(widget.inspiration!);
      _month = _inspiration.month;
      _timeOfMonth = _inspiration.timeOfMonth;
    } else {
      _changeTo(_defaultType);
      _month = Month.January;
      _timeOfMonth = TimeOfMonth.Any;
    }
  }

  void _changeTo(InspirationType selectedType) {
    setState(() {
      switch (selectedType) {
        case InspirationType.Note:
          _inspiration = NoteModel(key: _uuid.v4());
          break;
        case InspirationType.BulletList:
          _inspiration = BulletListModel(key: _uuid.v4());
          break;
        case InspirationType.Recipe:
          _inspiration = RecipeModel(key: _uuid.v4());
          break;
        case InspirationType.Birthday:
          _inspiration = BirthdayModel(key: _uuid.v4());
          break;
      }
    });
  }

  ButtonStyle _selectedStyle(InspirationType selectedType) {
    if (_inspiration.inspirationType == selectedType) {
      return TextButton.styleFrom(primary: AppColorScheme.accent);
    } else {
      return TextButton.styleFrom(primary: AppColorScheme.primary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InspirationsBloc, InspirationsState>(
        builder: (context, state) {
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
                _isEditing
                    ? Container()
                    : TypeSelector(
                        onSelect: (inspiration) {
                          setState(() {
                            _inspiration = inspiration;
                          });
                        },
                        initialValue: _isEditing
                            ? _inspiration.inspirationType
                            : _defaultType,
                      ),
                InspirationCard(inspiration: _inspiration, isEditing: true),
                Row(
                  children: [
                    Text(
                      Strings.editMonthAndTime,
                      style: TextStyle(
                          color: AppColorScheme.backgroundDarkForeground),
                    ),
                    TimeOfMonthDropdownButton(
                        value: _timeOfMonth,
                        onChanged: (TimeOfMonth? newValue) => setState(() {
                              _timeOfMonth = newValue!;
                            })),
                    MonthDropdownButton(
                        value: _month,
                        onChanged: (Month? newValue) => setState(() {
                              _month = newValue!;
                            })),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            widget.onSave(InspirationModel.copyWith(_inspiration,
                editedMonth: _month, editedTimeOfMonth: _timeOfMonth));
            Navigator.pop(context);
          },
          child: const Icon(Icons.check),
        ),
      );
    });
  }
}
