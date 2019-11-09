import 'package:ddi/di.dart';
import 'package:petisland_core/config/config.dart';
import 'package:petisland_core/module/module.dart';
import 'package:petisland_core/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{});
  await Config.initAsync(Mode.Debug);
  await DI.initAsync(<Module>[DevModuleCore()]);
  final AccountService service = DI.get(AccountService);
  group('account test', () {
    test('with require-code', () {
      final String email = 'meomeocf98@gmail.com';
      service.requireCode(email);
    });
  });
}
