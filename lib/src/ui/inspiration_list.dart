import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/ui/core/app_color_scheme.dart';
import 'package:yearly_flow/src/ui/core/strings.dart';
import 'package:yearly_flow/src/ui/inspiration_add.dart';
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
  @override
  void initState() {
    super.initState();
    bloc.fetchAllInspirations();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
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
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        InspirationAdd()));

    bloc.fetchAllInspirations();
  }

  void _deleteCard(InspirationModel inspiration) {
    bloc.delete(inspiration);
    bloc.fetchAllInspirations();
  }

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

  Widget buildListWithHeaders(AsyncSnapshot<ItemModel> snapshot) {
    return ListView.builder(
      itemCount: Month.values.length,
      itemBuilder: (context, index) {
        Month currentMonth = Month.values[index];
        List<InspirationModel> currentMonthCards = bloc
            .monthMap[currentMonth] ?? <InspirationModel>[];
        return StickyHeader(
          header: MonthHeader(currentMonth.displayTitle),
          content: Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: currentMonthCards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (contxt, indx) {
                var inspiration = currentMonthCards[indx];
                return Dismissible(
                  key: Key("${inspiration.title} + $indx"),
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
                    tag: "${inspiration.title} + $indx",
                    child: InspirationCard(
                      currentMonthCards[indx],
                      onTap: () => _openDetailPage(inspiration, index),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}