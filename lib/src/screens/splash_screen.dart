import 'package:flutter/material.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _SplashScreenState() : super();

  @override
  void initState() {
    super.initState();

    _setup();
  }

  void _setup() async {
    await Future.delayed(Duration(seconds: 1));

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => YearlyFlowApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColorScheme.primary,
        child: Center(
          child: Text(
            Strings.app_title,
            style: TextStyle(
              fontSize: 32.0,
              color: AppColorScheme.primaryForeground,
            ),
          ),
        ),
      ),
    );
  }
}
