import 'package:flutter/material.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/yearly_flow_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {

  const App():super(key: const Key('app_key'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yearly flow',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const YearlyFlowPage(),
    );
  }
}

