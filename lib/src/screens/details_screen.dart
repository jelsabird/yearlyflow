import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yearly_flow/src/blocs/blocs.dart';
import 'package:yearly_flow/src/screens/screens.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/widgets/inspiration_card.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InspirationsBloc, InspirationsState>(
      builder: (context, state) {
        final inspiration =
            (state as InspirationsLoadSuccess).year.getInspiration(id);
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.pageTitle_viewCard),
          ),
          body: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Hero(
                tag: "${id}__heroTag",
                child: InspirationCard(inspiration: inspiration,
        onDatePicked: () => {},),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            key:  YearlyFlowKeys.editButton,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddEditScreen(
                  inspiration: inspiration,
                  onSave: (inspiration) {
                    BlocProvider.of<InspirationsBloc>(context)
                        .add(InspirationUpdated(inspiration));
                    Navigator.pop(context, inspiration);
                  },
                ),
              ),
            ),
            child: const Icon(Icons.edit),
          ),
        );
      },
    );
  }
}
