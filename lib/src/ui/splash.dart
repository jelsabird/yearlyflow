import 'package:flutter/material.dart';
import 'package:yearly_flow/service_locator.dart';
import 'package:yearly_flow/src/blocs/splash_bloc.dart';
import 'package:yearly_flow/src/ui/core/app_color_scheme.dart';
import 'package:yearly_flow/src/ui/core/strings.dart';
import 'package:yearly_flow/src/app.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _SplashState() : super();

  late ISplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = locator.get<ISplashBloc>();

    _setup();
  }

  void _setup() async {
    await _bloc.init();
    await Future.delayed(Duration(seconds: 1));

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => App()));
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
