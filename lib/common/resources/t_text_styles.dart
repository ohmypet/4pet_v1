part of petisland.common.resources;

/// Font size default is **14**
///
/// **Back** is a color default
abstract class TTextStyles extends TextStyle {
  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.normal({double fontSize, Color color}) => _TTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.normal,
      );

  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.light({double fontSize, Color color}) => _TTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w400,
      );

  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.medium({double fontSize, Color color}) => _TTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w500,
      );

  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.semi({double fontSize, Color color}) => _TTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w600,
      );

  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.bold({double fontSize, Color color}) => _TTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w800,
      );

  /// Font size default is **14**
  ///
  /// **Back** is a color default
  factory TTextStyles.black({double fontSize, Color color}) => _TTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w900,
      );
}

class _TTextStyle extends TextStyle implements TTextStyles {
  const _TTextStyle({double fontSize, Color color, FontWeight fontWeight})
      : super(
          height: 1.4,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 14,
          color: color ?? TColors.black,
          fontFamily: FontFamilies.harmonia,
        );
}
