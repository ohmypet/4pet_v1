part of petisland.common.resources;

/// Font size default is **14**
///
/// **Back** is a color default
abstract class TTextStyles extends TextStyle {
  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.normal(
          {double fontSize, Color color, double letterSpacing}) =>
      _TTextStyle(
        fontSize: fontSize,
        color: color,
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.normal,
      );

  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.light(
          {double fontSize, Color color, double letterSpacing}) =>
      _TTextStyle(
        fontSize: fontSize,
        color: color,
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.w400,
      );

  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.medium(
          {double fontSize, Color color, double letterSpacing}) =>
      _TTextStyle(
        fontSize: fontSize,
        color: color,
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.w500,
      );

  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.semi(
          {double fontSize, Color color, double letterSpacing}) =>
      _TTextStyle(
        fontSize: fontSize,
        color: color,
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.w600,
      );

  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.bold(
          {double fontSize, Color color, double letterSpacing}) =>
      _TTextStyle(
        fontSize: fontSize,
        color: color,
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.w800,
      );

  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.black(
          {double fontSize, Color color, double letterSpacing}) =>
      _TTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w900,
        letterSpacing: letterSpacing,
      );
}

class _TTextStyle extends TextStyle implements TTextStyles {
  const _TTextStyle(
      {double fontSize,
      Color color,
      FontWeight fontWeight,
      double letterSpacing})
      : super(
          height: 1.4,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 14,
          color: color ?? TColors.black,
          fontFamily: FontFamilies.sarabun,
          letterSpacing: letterSpacing ?? 0,
        );
}
