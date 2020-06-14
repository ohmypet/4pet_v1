part of petisland.common.resources;

abstract class TGradients {
  static final defaultGradient = LinearGradient(
    colors: [
      TColors.black.withOpacity(0.10),
      TColors.black.withOpacity(0.15),
    ],
    stops: [0.2, 1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final shortGradient = LinearGradient(
    colors: [
      TColors.black.withOpacity(0.05),
      TColors.black.withOpacity(0.15),
    ],
    stops: [0.5, 0.85],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final avatarGradient = LinearGradient(
    colors: [
      TColors.light_blue,
      TColors.dark_violet,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final avatarGradient2 = LinearGradient(
    colors: [
      TColors.water_melon,
      TColors.dark_pink,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
