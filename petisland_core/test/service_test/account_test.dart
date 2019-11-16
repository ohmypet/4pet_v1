import 'package:ddi/di.dart';
import 'package:petisland_core/config/config.dart';
import 'package:petisland_core/domain/domain.dart';
import 'package:petisland_core/module/module.dart';
import 'package:petisland_core/petisland_core.dart';
import 'package:petisland_core/service/service.dart';
import 'package:petisland_core/util/log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{});
  await Config.initAsync(Mode.Debug);
  await DI.initAsync(<Module>[DevModuleCore()]);
  final AccountService service = DI.get(AccountService);
  group('account test', () {
    // test('with require-code', () async {
    //   final String email = 'meomeocf98@gmail.com';
    //   final Account account = await service.requireCode(email);
    //   expect(account, isNotNull);
    //   Log.debug(account.toJson());
    // });
    test('with register', () async {
      final String email = 'meomeocf98@gmail.com';
      final String code = '5224';
      final String username = 'meomeocf98';
      final String password = '123456';
      try {
        final Account account =
            await service.register(email, code, username, password);
        expect(account, isNotNull);
        Log.debug(account.toJson());
      } catch (ex) {
        Log.error('ex: $ex');
        if (ex is PetApiException) {
          expect(ex.statusCode, PetApiException.code_time_out);
        }
      }
    });

    test('with login', () async {
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
      } catch (ex) {
        Log.error(ex);
        expect(ex, isNotNull);
      }
    });
  });
}
