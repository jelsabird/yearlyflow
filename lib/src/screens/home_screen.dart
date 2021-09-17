import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yearly_flow/src/blocs/blocs.dart';
import 'package:yearly_flow/src/screens/add_edit_screen.dart';
import 'package:yearly_flow/src/widgets/widgets.dart';
import 'package:yearly_flow/src/core/core.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AutoScrollController _autoScrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical,
        suggestedRowHeight: 200);

    return BlocBuilder<InspirationsBloc, InspirationsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.app_title,
              style: TextStyle(
                  fontFamily: 'Bohemian',
                  fontSize: 50),
          ),),
          body: MonthSectionsList(
              key: YearlyFlowKeys.monthSectionsList,
              autoScrollController: _autoScrollController),
          floatingActionButton: FloatingActionButton(
            key: YearlyFlowKeys.addButton,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddEditScreen(
                    key: YearlyFlowKeys.addEditScreen,
                    onSave: (inspiration) {
                      BlocProvider.of<InspirationsBloc>(context)
                          .add(InspirationAdded(inspiration));
                      Navigator.pop(context, inspiration);
                    }),
              ),
            ),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
