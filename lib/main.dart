import 'package:flutter/material.dart';
import 'package:yearly_flow/service_locator.dart';
import 'package:yearly_flow/src/ui/splash.dart';
import 'package:yearly_flow/src/ui/core/styles.dart';

void main() {
  setupLocator();
  runApp(const App());
}

class App extends StatelessWidget {

  const App():super(key: const Key('app_key'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yearly flow',
      theme: ThemeDataConfig.configure(),
      home: const Splash(),
    );
  }
}

