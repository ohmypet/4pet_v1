part of petisland.common.utils;

class AccountUtils {
  static bool grantEditAndDel(Account accountFromPost) {
    final AuthenticationBloc currentAccount = DI.get(AuthenticationBloc);
    final Account account = currentAccount.account;
    if (accountFromPost?.id == account.id) {
      return true;
    } else
      return false;
  }
}
