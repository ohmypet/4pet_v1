import 'package:ddi/di.dart';
import 'package:petisland_core/domain/domain.dart';
import 'package:petisland_core/module/module.dart';
import 'package:petisland_core/petisland_core.dart';
import 'package:petisland_core/service/service.dart';
import 'package:petisland_core/utils/utils.dart';
import 'package:test/test.dart';

import 'configuration.dart';

void main() async {
  await setupEnvironment();

  final AccountService service = DI.get(AccountService);
  group('account test', () {
    // test('Check-code fail', () async {
    //   final email = 'gkh21926@eveav.com';
    //   final code = '566';

    //   final bool isCorrect = await service.checkCode(email, code);

    //   expect(isCorrect, false);
    // });

    final email = 'jpi09584@eveav.com';
    final code = '2994';
    test('Check-code is ok', () async {
      final bool isCorrect = await service.checkCode(email, code);

      expect(isCorrect, true);
    });
    // test('with require-code', () async {
    //   final String email = 'meomeocf98@gmail.com';
    //   final Account account = await service.requireCode(email);
    //   expect(account, isNotNull);
    //   Log.debug(account.toJson());
    // });
    test('with register', () async {
      final String username = 'meomeocf98';
      final String password = '123456';
      final User user = User(name: 'Vi Chi Thien', phoneNumber: '0966144938');
      try {
        final Account account = await service.register(
          email,
          code,
          username,
          password,
          user: user,
        );
        Log.debug(account.toJson());
        expect(account, isNotNull);
      } catch (ex) {
        Log.error('ex: $ex');
        if (ex is PetApiException) {
          expect(ex.statusCode, PetApiException.code_time_out);
        }
      }
    });

    // test('with login', () async {
    //   final String username = 'admin';
    //   final String password = 'admin';
    //   try {
    //     final LoginData loginData = await service.login(username, password);
    //     Log.debug(loginData.toJson());
    //     expect(loginData, isNotNull);
    //     expect(loginData.token, isNotNull);
    //     expect(loginData.account, isNotNull);
    //     expect(loginData.account.email, isNotNull);
    //     expect(loginData.account.username, isNotNull);
    //   } catch (ex) {
    //     Log.error(ex);
    //     expect(ex, isNotNull);
    //   }
    // });
  });
}
