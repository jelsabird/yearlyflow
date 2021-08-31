import 'package:flutter/material.dart';
import 'package:yearly_flow/src/ui/core/styles.dart';
import 'package:yearly_flow/src/ui/list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeDataConfig.configure(),
      home: Scaffold(
        body: InspirationList(),
      ),
    );
  }
}