import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
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

  late Inspiration inspiration = Inspiration();

  @override
  void initState() {
    super.initState();
  }

  void _editCard() {
    Navigator.push(
      context,
      MaterialPageRoute<EditCardPage>(
        builder: (BuildContext context) => const EditCardPage(),
        settings: RouteSettings(arguments: inspiration),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    inspiration = ModalRoute.of(context)!.settings.arguments as Inspiration;

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.pageTitle_viewCard),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: inspiration.getTitle,
              child: InspirationCard(inspiration)
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _editCard(),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
