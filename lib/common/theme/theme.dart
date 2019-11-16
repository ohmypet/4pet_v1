library petisland.common.theme;

import 'package:flutter/material.dart';
import 'package:flutter_template/common/common.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

abstract class PetIslandTheme {
  ThemeData getTheme();

  final TextTheme textTheme = TextTheme(
    body1: TTextStyles.normal(fontSize: 16, letterSpacing: 0.5),
    body2: TTextStyles.normal(fontSize: 14, letterSpacing: 0.25),
    display1: TTextStyles.light(fontSize: 96, letterSpacing: -1.5),
    display2: TTextStyles.light(fontSize: 60, letterSpacing: -0.5),
    display3: TTextStyles.normal(fontSize: 48),
    display4: TTextStyles.normal(fontSize: 34, letterSpacing: 0.25),
    headline: TTextStyles.normal(fontSize: 24),
    title: TTextStyles.normal(fontSize: 16, letterSpacing: 0.15),
    subtitle: TTextStyles.medium(fontSize: 14, letterSpacing: 0.1),
    subhead: TTextStyles.medium(fontSize: 20, letterSpacing: 0.15),
    button: TTextStyles.medium(fontSize: 14, letterSpacing: 1.25),
    caption: TTextStyles.normal(fontSize: 12, letterSpacing: 0.4),
    overline: TTextStyles.normal(fontSize: 10, letterSpacing: 1.5),
  );
}
