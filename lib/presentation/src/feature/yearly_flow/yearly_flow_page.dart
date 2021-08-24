import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/presentation/src/core/app_color_scheme.dart';
import 'package:yearly_flow/presentation/src/entity/month_section.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/view_card/view_card_page.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/yearly_flow_controller.dart';
import 'package:yearly_flow/domain/src/entity/enums/month.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/add_card'
    '/add_card_page.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/widgets/inspiration_card.dart';
import 'package:yearly_flow/presentation/src/widgets/month_header.dart';

class YearlyFlowPage extends StatefulWidget {
  const YearlyFlowPage({Key? key}) : super(key: key);

  @override
  _YearlyFlowPageState createState() => _YearlyFlowPageState();
}

class _YearlyFlowPageState extends State<YearlyFlowPage> {
  _YearlyFlowPageState() : super();

  late YearlyFlowController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YearlyFlowController();
    _controller.init();

    _loadData();
  }

  void _loadData() {
    _controller.loadInspirations();

    setState(() {});
  }

  Future<void> _addCard(Month month) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
    AddCardPage()));

    _loadData();

    return Future.value();
  }

  Future<void> _viewCard(Inspiration inspiration) async {
    await Navigator.of(context).push(_createRoute(
        const ViewCardPage(),
        RouteSettings(arguments: [
          inspiration,
          _controller.inspirations.indexOf(inspiration)
        ])));

    _loadData();

    return Future.value();
  }

  void _deleteCard(Inspiration inspiration) {
    _controller.deleteInspiration(inspiration);

    _loadData();
  }

  Route _createRoute(Widget destination, RouteSettings routeSettings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      settings: routeSettings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  Widget listWithHeaders() {
    return ListView.builder(
      itemCount: _controller.months.length,
      itemBuilder: (context, index) {
        MonthSection currentMonth = _controller.months[index];
        List<Inspiration> currentMonthCards =
            _controller.getMonthInspirations(currentMonth.number);
        return StickyHeader(
          header: MonthHeader(currentMonth.title),
          content: Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: currentMonthCards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
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
                  background: Row(
                    children: [
                      Flexible(
                        flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.delete, color: AppColorScheme
                                .backgroundDarkForeground,),
                          )
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(''),
                      ),
                    ]
                  ),
                  child: Hero(
                    tag: "${inspiration.title} + $indx",
                    child: InspirationCard(
                      currentMonthCards[indx],
                      onTap: () => _viewCard(inspiration),
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

  @override
  Widget build(BuildContext context) {
    _loadData();

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.app_title),
      ),
      body: listWithHeaders(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addCard(_controller.months[0].month),
        child: const Icon(Icons.add),
      ),
    );
  }
}
