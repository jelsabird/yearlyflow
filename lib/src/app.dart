import 'package:flutter/material.dart';
import 'package:yearly_flow/src/screens/screens.dart';
import 'package:yearly_flow/src/core/core.dart';

class YearlyFlowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.app_title,
      theme: ThemeDataConfig.configure(),
      home: HomeScreen(key: YearlyFlowKeys.homeScreen)
    );
  }
}