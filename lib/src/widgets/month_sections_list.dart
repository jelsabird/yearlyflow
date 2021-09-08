import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:yearly_flow/src/blocs/blocs.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/widgets/widgets.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/screens/screens.dart';
import 'package:yearly_flow/src/widgets/inspiration_card.dart';

class MonthSectionsList extends StatelessWidget {
  final AutoScrollController autoScrollController;

  MonthSectionsList({Key? key, required this.autoScrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InspirationsBloc, InspirationsState>(
        builder: (context, state) {
      if (state is InspirationsLoadInProgress) {
        return Center(child: CircularProgressIndicator());
      } else if (state is InspirationsLoadSuccess) {
        final monthSections = state.year.getMonths();
        return ListView.builder(
          controller: autoScrollController,
          itemCount: monthSections.length,
          itemBuilder: (monthContext, monthIndex) {
            Month month = monthSections[monthIndex].month;
            List<InspirationModel> inspirations =
                monthSections[monthIndex].inspirations;
            return _wrapScrollTag(
              index: monthIndex,
              child: StickyHeader(
                header: MonthHeader(month.displayTitle),
                content: Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: inspirations.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      var inspiration = inspirations[index];
                      return Dismissible(
                        key: Key("${inspiration.title} + $index"),
                        onDismissed: (direction) {
                          BlocProvider.of<InspirationsBloc>(context)
                              .add(InspirationDeleted(inspiration));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Slettet ${inspiration.title}"),
                            ),
                          );
                        },
                        background: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.delete,
                                  color:
                                      AppColorScheme.backgroundDarkForeground,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(''),
                            ),
                          ],
                        ),
                        child: Hero(
                          tag: "${inspiration.key}__heroTag",
                          child: InspirationCard(
                            inspiration: inspirations[index],
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DetailScreen(
                                  id: inspiration.key,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      } else {
        return Container(
          child: Text("Load failure"),
        );
      }
    });
  }

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
          key: ValueKey<int>(index),
          controller: autoScrollController,
          index: index,
          child: child);
}
