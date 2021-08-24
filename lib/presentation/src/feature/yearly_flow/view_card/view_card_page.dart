import 'package:flutter/material.dart';
import 'package:yearly_flow/data/src/repository/data_controller.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/edit_card/edit_card_page.dart';
import 'package:yearly_flow/presentation/src/widgets/inspiration_card.dart';

class ViewCardPage extends StatefulWidget {
  const ViewCardPage({Key? key}) : super(key: key);

  @override
  _ViewCardPageState createState() => _ViewCardPageState();
}

class _ViewCardPageState extends State<ViewCardPage> {
  _ViewCardPageState() : super();

  late Inspiration _inspiration;

  @override
  void initState() {
    super.initState();

    _inspiration = Note();
  }

  Future<void> _editCard() async {
    await Navigator.push(
      context,
      MaterialPageRoute<EditCardPage>(
        builder: (BuildContext context) => const EditCardPage(),
        settings: RouteSettings(arguments: _inspiration),
      ),
    );

    setState(() {});

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments as List<Object>;
    _inspiration = arguments[0] as Inspiration;
    var index = arguments[1] as int;

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.pageTitle_viewCard),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
              tag: "${_inspiration.title} + $index",
              child: InspirationCard(_inspiration),),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _editCard(),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
