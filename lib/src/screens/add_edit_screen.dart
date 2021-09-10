import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:yearly_flow/src/blocs/blocs.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/widgets/widgets.dart';

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
  Uuid _uuid = Uuid();

  @override
  void initState() {
    super.initState();

    _inspiration = _isEditing
        ? InspirationModel.copyWith(widget.inspiration!)
        : NoteModel(key: _uuid.v4());
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
                  key: YearlyFlowKeys.typeSelector,
                        onSelect: (inspiration) {
                          setState(() {
                            _inspiration = inspiration;
                          });
                        },
                        initialValue: _isEditing
                            ? _inspiration.inspirationType
                            : _defaultType,
                      ),
                InspirationCard(inspiration: _inspiration, isEditing: true,
                  onDatePicked: () => setState(() {}),),
                MonthSelector(
                  key: YearlyFlowKeys.monthSelector,
                    inspiration: _inspiration,
                    isEditable: _inspiration.inspirationType !=
                        InspirationType.Birthday),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: YearlyFlowKeys.saveButton,
          onPressed: () {
            widget.onSave(InspirationModel.copyWith(_inspiration));
          },
          child: const Icon(Icons.check),
        ),
      );
    });
  }
}
