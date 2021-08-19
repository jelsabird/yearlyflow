import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/presentation/src/entity/month_section.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/yearly_flow_controller.dart';
import 'package:yearly_flow/domain/src/util/enums/month.dart';
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

  void _loadData() async {
    await _controller.loadInspirations();

    setState(() {});
  }

  void _addCard(Month month) {
    Navigator.push(
      context,
      MaterialPageRoute<AddCardPage>(
          builder: (BuildContext context) => const AddCardPage(),
          settings: RouteSettings(arguments: month)),
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
              return InspirationCard(currentMonthCards[indx]);
            },
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
