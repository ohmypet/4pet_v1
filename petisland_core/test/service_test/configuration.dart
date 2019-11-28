import 'package:flutter_test/flutter_test.dart';
import 'package:petisland_core/config/config.dart';
import 'package:petisland_core/module/module.dart';
import 'package:petisland_core/petisland_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setupEnvironment() async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{});
  await Config.initAsync(Mode.Debug);
  await DI.initAsync(<Module>[DevModuleCore()]);
}

void login() {
  final AccountService service = DI.get(AccountService);
  final LocalStorageService storageService = DI.get(LocalStorageService);

  test('Login with username: admin, password: admin', () async {
    final String username = 'admin';
    final String password = 'admin';
    try {
      final LoginData loginData = await service.login(username, password);
      Log.debug(loginData.toJson());
      expect(loginData, isNotNull);
      expect(loginData.token, isNotNull);
      expect(loginData.account, isNotNull);
      expect(loginData.account.email, isNotNull);
      expect(loginData.account.username, isNotNull);
      await storageService.updateToken(loginData.token);
    } catch (ex) {
      Log.error(ex);
      expect(ex, isNotNull);
    }
  });
}
