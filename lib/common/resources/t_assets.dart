part of petisland.common.resources;

abstract class TAssets {
  @protected
  static const String iconPath = 'assets/icons';

  @protected
  static const String petTypePath = '$iconPath/pet_type';

  @protected
  static const String flarePath = 'assets/flare';

  static const String post_default_image_avatar = '$iconPath/kitty.svg';

  static const String user_avatar = '$iconPath/user.svg';
  static const String logout = '$iconPath/logout.svg';
  static const String moon = '$iconPath/moon.svg';
  static const String note = '$iconPath/note.svg';


  // pet type
  static const String pet_type_fish = '$petTypePath/fish.svg';
  static const String pet_type_dog = '$petTypePath/dog.svg';
  static const String pet_type_bird = '$petTypePath/bird.svg';
  static const String pet_type_cat = '$petTypePath/cat.svg';
  static const String pet_type_other = '$petTypePath/other.svg';

  static const String flare_loading = '$flarePath/loading.flr';
  static const String flare_like = '$flarePath/like.flr';

}
