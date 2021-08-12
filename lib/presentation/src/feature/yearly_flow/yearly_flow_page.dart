import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yearly_flow/presentation/src/entity/month_section.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/yearly_flow_controller.dart';
import 'package:yearly_flow/presentation/src/widgets/card_template.dart';
import 'package:yearly_flow/domain/src/util/enums/month.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/add_card'
    '/add_card_page.dart';

class YearlyFlowPage extends StatefulWidget {
  const YearlyFlowPage({Key? key}) : super(key: key);

  @override
  _YearlyFlowPageState createState() => _YearlyFlowPageState();
}

class _YearlyFlowPageState extends State<YearlyFlowPage> {
  _YearlyFlowPageState() : super();

  late YearlyFlowController _controller;
  final CardTemplate _cardTemplate = CardTemplate();

  late AutoScrollController _autoScrollController;
  final int _currentMonthIndex = DateTime.now().month - 1;

  @override
  void initState() {
    super.initState();

    _controller = YearlyFlowController();
    _controller.init();

    _autoScrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical,
        suggestedRowHeight: 200);

    _loadData();
  }

  void _loadData() async {
    await _controller.loadInspirations();

    setState(() {});
  }

  void scrollToIndex() {
    _autoScrollController.scrollToIndex(_currentMonthIndex,
        preferPosition: AutoScrollPosition.begin);
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    super.dispose();
  }

  Widget _buildMonthList() {
    return _buildListView();
  }

  ListView _buildListView() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      controller: _autoScrollController,
      children: _getMonthWidgets(),
    );
  }

  List<Widget> _getMonthWidgets() {
    final List<Widget> monthWidgets = <Widget>[];

    for (int index = 0; index < _controller.months.length; index++) {
      monthWidgets.add(
        _getRow(
          index,
          _controller.months[index],
        ),
      );
    }

    return monthWidgets;
  }

  Widget _getRow(int index, MonthSection month) {

    return _wrapScrollTag(
      index: index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
          children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            month.title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.tealAccent,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: _cardTemplate.getTemplateList(_controller.getMonthInspirations(month.number)),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Legg til kort',
          color: Colors.white,
          onPressed: () {
            _addCard(month.month);
          }
        ),
      ]),
    );
  }

  void _addCard(Month month) {
    Navigator.push(context, MaterialPageRoute<AddCardPage>(
      builder: (BuildContext context) => const AddCardPage(),
      settings: RouteSettings(
        arguments: month
      )
    ),);
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
      backgroundColor: const Color(0xFF303030),
      appBar: AppBar(
        title: const Text('Yearly flow'),
      ),
      body: _buildMonthList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.calendar_today),
        onPressed: scrollToIndex,
      ),
    );
  }
}
