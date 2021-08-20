import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yearly_flow/presentation/src/core/app_color_scheme.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/splash/splash_controller.dart';
import 'package:yearly_flow/presentation/src/feature/yearly_flow/yearly_flow_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _SplashPageState() : super();

  late SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashController();

    _setup();
  }

  void _setup() async {
    await _controller.init();
    await Future.delayed(Duration(seconds: 1));

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => YearlyFlowPage()));
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
