import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:flutter/material.dart';

class KLightTheme extends KThemeModeApp {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color.fromRGBO(78, 115, 223, 1);
  late Color secondary = const Color.fromRGBO(22, 160, 133, 1);
  late Color tertiary = Color.fromARGB(255, 221, 48, 48);
  late Color alternate = const Color(0xFFF19642);
  late Color primaryText = const Color(0xFF0D121D);
  late Color secondaryText = const Color(0xFF57636C);
  late Color primaryBackground = const Color.fromARGB(255, 255, 255, 255);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color.fromRGBO(78, 115, 223, 1);
  late Color accent2 = const Color.fromRGBO(26, 187, 155, 1);
  late Color accent3 = Colors.redAccent;
  late Color accent4 = const Color(0xFFEEEEEE);
  late Color success = const Color(0xFF04A24C);
  late Color warning = const Color(0xFFFCDC0C);
  late Color error = const Color(0xFFE21C3D);
  late Color info = const Color(0xFF1C4494);

  late Color primaryBtnText = Color(0xFFFFFFFF);
  late Color lineColor = Color(0xFFE0E3E7);
  late Color white70 = Color(0xB3FFFFFF);
  late Color primary600 = Color(0xFFCB0A41);
}
