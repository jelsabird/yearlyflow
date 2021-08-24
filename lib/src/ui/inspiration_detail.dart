import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/entity/enums/month.dart';
import 'package:yearly_flow/domain/src/entity/enums/time_of_month.dart';

class InspirationDetail extends StatefulWidget {
  final String dbKey;
  final InspirationType inspirationType;
  final Month month;
  final TimeOfMonth timeOfMonth;
  final String title;

  InspirationDetail({
    required this.dbKey,
    required this.inspirationType,
    required this.month,
    required this.timeOfMonth,
    required this.title,
  });

  @override
  InspirationDetailState createState() {
    return InspirationDetailState(
      dbKey: dbKey,
      inspirationType: inspirationType,
      month: month,
      timeOfMonth: timeOfMonth,
      title: title,
    );
  }
}

class InspirationDetailState extends State<InspirationDetail> {
  final String dbKey;
  final InspirationType inspirationType;
  final Month month;
  final TimeOfMonth timeOfMonth;
  final String title;

  InspirationDetailState({
    required this.dbKey,
    required this.inspirationType,
    required this.month,
    required this.timeOfMonth,
    required this.title,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool
        innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Card(),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 5.0)),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Row(
                  children: <Widget>[
                    Icon(Icons.delete, color: Colors.red,),
                    Container(margin: EdgeInsets.only(left: 1.0, right: 1.0),),
                    Text(timeOfMonth.displayString, style: TextStyle(fontSize: 18.0),),
                    Container(margin: EdgeInsets.only(left: 10.0, right: 10.0),),
                    Text(month.displayTitle, style: TextStyle(fontSize: 18.0),),
                  ],
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0),),
                Text('(Content)')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
