import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/ui/core/app_color_scheme.dart';
import 'package:yearly_flow/src/ui/core/strings.dart';
import 'package:yearly_flow/src/ui/events/Inspiration_created_event.dart';
import 'package:yearly_flow/src/ui/inspiration_add.dart';
import 'package:yearly_flow/src/ui/util/event_bus_utils.dart';
import 'package:yearly_flow/src/ui/widgets/inspiration_card.dart';
import 'package:yearly_flow/src/ui/widgets/month_header.dart';
import 'package:yearly_flow/src/models/item_model.dart';
import 'package:yearly_flow/src/blocs/inspiration_list_bloc.dart';
import 'package:yearly_flow/src/ui/inspiration_detail.dart';

class InspirationList extends StatefulWidget {
  @override
  _InspirationListState createState() => _InspirationListState();
}

class _InspirationListState extends State<InspirationList> {
  late StreamSubscription _subscribtion;
  late AutoScrollController _autoScrollController;
  final int _currentMonthIndex = DateTime.now().month - 1;

  @override
  void initState() {
    super.initState();

    _autoScrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical,
        suggestedRowHeight: 200);

    bloc.fetchAllInspirations();

    _subscribtion = EventBusUtils.instance.on<CardUpdatedEvent>().listen
      (_scrollToCard);

    _scrollToMonth();
  }

  void _scrollToCard(CardUpdatedEvent event) {
    _scrollToMonth(index: event.month.index);
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    _subscribtion.cancel();
    bloc.dispose();
    super.dispose();
  }

  void _scrollToMonth({int? index}) {
    _autoScrollController.scrollToIndex(index ?? _currentMonthIndex,
        preferPosition: AutoScrollPosition.begin);
  }

  Future<void> _openDetailPage(InspirationModel inspiration, int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return InspirationDetail(
          model: inspiration,
          index: index,
        );
      }),
    );

    bloc.fetchAllInspirations();
  }

  Future<void> _addCard() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => InspirationAdd()));

    bloc.fetchAllInspirations();
  }

  void _deleteCard(InspirationModel inspiration) {
    bloc.delete(inspiration);
    bloc.fetchAllInspirations();
  }

  Widget buildListWithHeaders(AsyncSnapshot<ItemModel> snapshot) {
    return ListView.builder(
      controller: _autoScrollController,
      itemCount: Month.values.length,
      itemBuilder: (monthContext, monthIndex) {
        Month currentMonth = Month.values[monthIndex];
        List<InspirationModel> currentMonthCards =
            bloc.monthMap[currentMonth] ?? <InspirationModel>[];
        return _wrapScrollTag(
          index: monthIndex,
          child: StickyHeader(
            header: MonthHeader(currentMonth.displayTitle),
            content: Container(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: currentMonthCards.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  var inspiration = currentMonthCards[index];
                  return Dismissible(
                    key: Key("${inspiration.title} + $index"),
                    onDismissed: (direction) {
                      setState(() {
                        _deleteCard(inspiration);
                        currentMonthCards.remove(inspiration);
                      });
                    },
                    background: Row(children: [
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.delete,
                              color: AppColorScheme.backgroundDarkForeground,
                            ),
                          )),
                      Flexible(
                        flex: 1,
                        child: Text(''),
                      ),
                    ]),
                    child: Hero(
                      tag: "${inspiration.title} + $index",
                      child: InspirationCard(
                        currentMonthCards[index],
                        onTap: () => _openDetailPage(inspiration,
                            index),
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
  }

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
          key: ValueKey<int>(index),
          controller: _autoScrollController,
          index: index,
          child: child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.app_title),
      ),
      body: StreamBuilder(
        stream: bloc.allInspirations,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildListWithHeaders(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addCard(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
