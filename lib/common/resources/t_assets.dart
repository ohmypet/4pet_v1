part of petisland.common.resources;

// ignore_for_file: non_constant_identifier_names
abstract class TAssets {
  @protected
  static final random = Random();

  @protected
  static const String iconPath = 'assets/icons';

  @protected
  static const String petTypePath = '$iconPath/pet_type';

  @protected
  static const String flarePath = 'assets/flare';

  static String get post_default_image_avatar =>
      '$iconPath/kitty/kitty_${random.nextInt(50) + 1}.svg';

  static final String user_avatar = '$iconPath/kitty/kitty_${random.nextInt(50) + 1}.svg';
  static const String logout = '$iconPath/logout.svg';
  static const String moon = '$iconPath/moon.svg';
  static const String note = '$iconPath/note.svg';

  // image
  static const String splash = 'assets/images/app_icon.png';


  // pet type
  static const String pet_type_fish = '$petTypePath/fish.svg';
  static const String pet_type_dog = '$petTypePath/dog.svg';
  static const String pet_type_bird = '$petTypePath/bird.svg';
  static final String pet_type_cat =
      '$iconPath/kitty/kitty_${random.nextInt(50) + 1}.svg';
  static const String pet_type_other = '$petTypePath/other.svg';

  static const String flare_loading = '$flarePath/loading.flr';
  static const String flare_like = '$flarePath/like.flr';
}
