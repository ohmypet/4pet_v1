import 'package:flutter_test/flutter_test.dart';
import 'package:petisland_core/petisland_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{});
  await Config.initAsync(Mode.Debug);
  await DI.initAsync(<Module>[DevModuleCore()]);
  final AccountService service = DI.get(AccountService);
  final ImageService imageService = DI.get(ImageService);
  final LocalStorageService storageService = DI.get(LocalStorageService);

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
      await storageService.updateToken(loginData.token);
    } catch (ex) {
      Log.error(ex);
      expect(ex, isNotNull);
    }
  });

  test('upload image', () async {
    final String path = 'assets/meow.jpeg';
    try {
      final List<PetImage> images = await imageService.upload(<String>[path, path]);

      for (PetImage item in images) {
        Log.debug(item.toJson());
      }
    } catch (ex) {
      Log.error(ex);
    }
  });
}
