import 'package:flutter_test/flutter_test.dart';
import 'package:petisland_core/petisland_core.dart';

import 'configuration.dart';

void main() async {
  await setupEnvironment();

  final ImageService imageService = DI.get(ImageService);

  login();

  test('upload image', () async {
    final String path = 'assets/meow.jpeg';
    try {
      final List<PetImage> images =
          await imageService.upload(<String>[path, path]);

      for (PetImage item in images) {
        Log.debug(item.toJson());
      }
    } catch (ex) {
      Log.error(ex);
    }
  });
}
