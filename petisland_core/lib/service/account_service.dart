import 'package:petisland_core/domain/domain.dart';

abstract class AccountService {
  Future<Account> requireCode(String email);

  Future<Account> register(String email, String code, String username, String password);

  Future<LoginData> login(String email, String password);
}
