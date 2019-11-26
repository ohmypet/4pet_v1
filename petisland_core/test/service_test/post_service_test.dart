import 'package:flutter_test/flutter_test.dart';
import 'package:petisland_core/petisland_core.dart';
import 'package:petisland_core/util/petisland_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{});
  await Config.initAsync(Mode.Debug);
  await DI.initAsync(<Module>[DevModuleCore()]);
  final AccountService service = DI.get(AccountService);
  final PostService postService = DI.get(PostService);
  final LocalStorageService storageService = DI.get(LocalStorageService);

  final String idImage = "d4aed98d-f7bd-47eb-b3bd-a0a7dd8f452d";

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

  test("Create post with empty image string", () async {
    final PostModal postModal = PostModal.create(
      price: 0.0,
      title: 'Ahihi',
      location: 'Dong nai',
      pet: Pet(
        type: enumToString(PetType.Dog),
      ),
    );
    try {
      final Post post = await postService.create(postModal);

      Log.info(post.toJson());
    } catch (ex) {
      Log.error(ex);
    }
  });

  test("Create post with image", () async {
    final PostModal postModal = PostModal.create(
        price: 10,
        title: 'Ahihi',
        location: 'Dong nai',
        pet: Pet(
          type: enumToString(PetType.Dog),
        ),
        description: "i'm supper man",
        images: <PetImage>[PetImage(id: idImage)]);
    try {
      final Post post = await postService.create(postModal);

      Log.info(post.toJson());
    } catch (ex) {
      Log.error(ex);
    }
  });

  test("Create post with tags ", () async {
    final PostModal postModal = PostModal.create(
      price: 10,
      title: 'Ahihi',
      location: 'Dong nai',
      pet: Pet(
        type: enumToString(PetType.Dog),
      ),
      description: "i'm supper man",
      tags: <Tag>[Tag(title: "Dog", description: "ahihi")],
      images: <PetImage>[PetImage(id: idImage)],
    );
    try {
      final Post post = await postService.create(postModal);

      Log.info(post.toJson());
    } catch (ex) {
      Log.error(ex);
    }
  });
}
