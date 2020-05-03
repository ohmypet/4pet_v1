library petisland.common.theme;

import 'package:flutter/material.dart';
import 'package:flutter_template/common/common.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

abstract class PetIslandTheme {
  ThemeData getTheme();

  final TextTheme textTheme = TextTheme(
    bodyText2: TTextStyles.normal(fontSize: 16, letterSpacing: 0.5),
    bodyText1: TTextStyles.normal(fontSize: 14, letterSpacing: 0.25),
    headline4: TTextStyles.light(fontSize: 96, letterSpacing: -1.5),
    headline3: TTextStyles.light(fontSize: 60, letterSpacing: -0.5),
    headline2: TTextStyles.normal(fontSize: 48),
    headline1: TTextStyles.normal(fontSize: 34, letterSpacing: 0.25),
    headline5: TTextStyles.normal(fontSize: 24),
    headline6: TTextStyles.normal(fontSize: 16, letterSpacing: 0.15),
    subtitle2: TTextStyles.medium(fontSize: 14, letterSpacing: 0.1),
    subtitle1: TTextStyles.medium(fontSize: 20, letterSpacing: 0.15),
    button: TTextStyles.medium(fontSize: 14, letterSpacing: 1.25),
    caption: TTextStyles.normal(fontSize: 12, letterSpacing: 0.4),
    overline: TTextStyles.normal(fontSize: 10, letterSpacing: 1.5),
  );
}
