part of petisland.common.theme;

class PetIslandLightTheme extends PetIslandTheme {
  @override
  ThemeData getTheme() {
    return ThemeData.from(
      colorScheme: ColorScheme(
        primary: TColors.water_melon,
        onPrimary: TColors.text_white,
        primaryVariant: TColors.water_melon_dark,
        secondary: TColors.scarlet_gum,
        secondaryVariant: TColors.water_melon_dark,
        onSecondary: TColors.black,
        background: Colors.white,
        onBackground: TColors.black,
        brightness: Brightness.light,
        surface: Colors.white,
        onSurface: TColors.black,
        error: TColors.error,
        onError: Colors.white,
      ),
      textTheme: textTheme,
    );
  }
}
