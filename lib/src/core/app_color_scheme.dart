import 'package:flutter/material.dart';

class AppColorScheme {

  static Swatch sw = Icecream();

  static Color primary = sw.primary;
  static Color accent = sw.primaryAccent;
  static Color backgroundDark = sw.secondaryAccent;
  static Color backgroundLight = sw.secondary;

  static Color primaryForeground = Colors.black;
  static Color accentForeground = Colors.black;
  static Color backgroundDarkForeground = Colors.white;
  static Color backgroundLightForeground = Colors.black;
}

abstract class Swatch {
  Color get primary;
  Color get primaryAccent;
  Color get secondary;
  Color get secondaryAccent;
}

class Summer extends Swatch {
  Color get primary => Color(0xFFA8DF70);
  Color get primaryAccent => Color(0xFFAB2051);
  Color get secondary => Colors.white;
  Color get secondaryAccent => Color(0xFFFFFDF1);
}

class Icecream extends Swatch {
  Color get primary => Color(0xFFD4DDEC); // Color(0xFFE3A486)
  Color get primaryAccent => Color(0xFFDB456E);
  Color get secondary => Colors.white; // Color(0xFFCAA2CD);
  Color get secondaryAccent => Color(0xFFFFFDF1); // Color(0xFFD4DDEC);
}

// Color(0xFFCAA2CD) lilla
// Color(0xFFDB456E) rosa
// Color(0xFFFFFDF1) lys gul