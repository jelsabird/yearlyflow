import 'package:flutter/material.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/splash/splash_page.dart';
import 'package:yearly_flow/presentation/src/core/styles.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {

  const App():super(key: const Key('app_key'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yearly flow',
      theme: ThemeDataConfig.configure(),
      home: const SplashPage(),
    );
  }
}

