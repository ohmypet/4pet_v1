part of petisland.common.resources;

abstract class TConstants {
  static const String pet_island = 'Pet Island';

  static const String hint_username = 'Username';

  static const String hint_password = 'Password';

  static const String hint_email = 'Email';

  static const String hint_code = 'Code';

  static const String hint_new_password = 'New Password';

  static const String hint_re_password = 'Re-Password';

  static const String text_login = 'LOGIN';

  static const String text_register = 'I don\'t have account? Sign Up';

  static const String text_forget_password = 'Forget password?';

  static const String text_submit_email = 'Send';

  static const String text_submit_code = 'Submit';

  static const String text_submit_password = 'Update';
  static const double ratio4y3 = 0.75;

  static const String join_now = 'JOIN NOW';

  static const String donate = 'Donate';

  static const String error = 'Something went wrong, try again later!';

  static const border_top_left = BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(10),
  );
  // ignore: non_constant_identifier_names
  static final border_all = BorderRadius.circular(7);
}
