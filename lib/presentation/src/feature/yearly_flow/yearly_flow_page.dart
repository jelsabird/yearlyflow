import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/domain/src/util/enums/inspiration_type.dart';
import 'package:yearly_flow/presentation/src/core/app_color_scheme.dart';
import 'package:yearly_flow/presentation/src/core/styles.dart';
import 'package:yearly_flow/presentation/src/entity/month_section.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/yearly_flow_controller.dart';
import 'package:yearly_flow/presentation/src/widgets/card_template.dart';
import 'package:yearly_flow/domain/src/util/enums/month.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/add_card'
    '/add_card_page.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';

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

  List<StaggeredTile> _staggeredTiles = <StaggeredTile>[];

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

  void _addCard(Month month) {
    Navigator.push(
      context,
      MaterialPageRoute<AddCardPage>(
          builder: (BuildContext context) => const AddCardPage(),
          settings: RouteSettings(arguments: month)),
    );
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    super.dispose();
  }

  StaggeredGridView? _buildStaggeredGridView() {
    return StaggeredGridView.count(
      crossAxisCount: 8,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      staggeredTiles: _staggeredTiles,
      children: _buildCardListWithMonthHeaders(),
    );
  }

  List<Widget> _buildCardListWithMonthHeaders() {
    List<Widget> fullList = <Widget>[];
    _staggeredTiles.clear();

    for (int index = 0; index < _controller.months.length; index++) {
      MonthSection currentMonth = _controller.months[index];
      fullList.add(_getMonthHeader(index, currentMonth));
      _staggeredTiles.add(StaggeredTile.count(8, 1));

      List<Inspiration> monthInspirations =
          _controller.getMonthInspirations(currentMonth.number);

      for (Inspiration i in monthInspirations) {
        fullList.add(_getCard(i));
        _staggeredTiles.add(_getSizedTile(i));
      }

      fullList.add(_getAddButton(currentMonth.month));
      _staggeredTiles.add(StaggeredTile.count(8, 1));
    }

    return fullList;
  }

  StaggeredTile _getSizedTile(Inspiration inspiration){
    switch(inspiration.inspirationType){
      case InspirationType.Note: return StaggeredTile.count(4, 6);
      case InspirationType.Birthday: return StaggeredTile.count(8, 2);
      case InspirationType.BulletList: return StaggeredTile.count(4, 6);
      case InspirationType.Recipe: return StaggeredTile.count(8, 6);
      case InspirationType.CheckList: return StaggeredTile.count(1, 1);
    }
  }

  Widget _getMonthHeader(int index, MonthSection month) {
    return _wrapScrollTag(
      index: index,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              month.title,
              style: Styles.monthHeaderStyle
            ),
          )),
    );
  }

  Widget _getCard(Inspiration inspiration) {
    return _cardTemplate.getTemplate(inspiration);
  }

  Widget _getAddButton(Month month) {
    return Center(
      child: IconButton(
          icon: const Icon(Icons.add),
          tooltip: Strings.hintText_addCard,
          color: AppColorScheme.backgroundDarkForeground,
          onPressed: () {
            _addCard(month);
          }),
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
        title: const Text(Strings.app_title),
      ),
      body: _buildStaggeredGridView(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.calendar_today), onPressed: scrollToIndex),
    );
  }
}
