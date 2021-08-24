import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/src/models/month_section_model.dart';
import 'package:yearly_flow/src/blocs/inspirations_bloc.dart';
import 'package:yearly_flow/src/ui/inspiration_detail.dart';

class InspirationList extends StatefulWidget {
  @override
  InspirationListState createState() => InspirationListState();
}

class InspirationListState extends State<InspirationList> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inspirasjon gjennom året'),
      ),
      body: StreamBuilder(
        stream: bloc.allInspirations,
        builder: (context, AsyncSnapshot<MonthSectionModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          }
          else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<MonthSectionModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data!.inspirationCards.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
                enableFeedback: true,
                child: Card(
                  child: Text(snapshot.data!.inspirationCards[index].title),
                ),
                onTap: () => openDetailPage(snapshot.data!, index),
            ),
          );
        });
  }

  openDetailPage(MonthSectionModel data, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          Inspiration inspiration = data.inspirationCards[index];
          return InspirationDetail(
              dbKey: inspiration.key,
              inspirationType: inspiration.inspirationType,
              month: inspiration.month,
              timeOfMonth: inspiration.timeOfMonth,
              title: inspiration.title);
        })
    );
  }
}
