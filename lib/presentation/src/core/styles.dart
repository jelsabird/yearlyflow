import 'package:flutter/material.dart';
import 'package:yearly_flow/presentation/src/core/app_color_scheme.dart';

class ThemeDataConfig {
  static ThemeData configure() {
    return ThemeData(
      primaryColor: AppColorScheme.primary,
      accentColor: AppColorScheme.accent,
      backgroundColor: AppColorScheme.backgroundDark,
      scaffoldBackgroundColor: AppColorScheme.backgroundDark,
      fontFamily: "Roboto",
      textTheme: TextTheme(
        headline1: Styles.cardTitleStyle,
        bodyText1: Styles.cardBodyStyle,
      ),
      cardTheme: CardTheme(
        color: AppColorScheme.backgroundLight,
        elevation: 4.0,
        margin: EdgeInsets.all(16.0),
      ),
      buttonTheme: ButtonThemeData(
        minWidth: 60.0,
        textTheme: ButtonTextTheme.primary,
        focusColor: Colors.amber
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: AppColorScheme.primaryForeground,
      ),
      buttonBarTheme: ButtonBarThemeData(
        alignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        buttonTextTheme: ButtonTextTheme.accent,
        buttonHeight: 36.0,
        buttonPadding: EdgeInsets.all(4.0),
        layoutBehavior: ButtonBarLayoutBehavior.constrained,
      ),
    );
  }
}

class Styles {
  static const TextStyle cardTitleStyle =
      TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);

  static const TextStyle cardBodyStyle = TextStyle(
    fontSize: 14.0,
  );

  static const TextStyle monthHeaderStyle = TextStyle(
    fontSize: 20.0,
    color: AppColorScheme.accent
  );
}
