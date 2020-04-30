import 'package:ddi/di.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petisland_core/petisland_core.dart';

import 'configuration.dart';

void main() async {
  await setupEnvironment();
  login();

  final PetCategoryService service = DI.get(PetCategoryService);

  test('Get categories', () async {
    try {
      final List<PetCategory> categories = await service.getPetCategories();
      for (PetCategory item in categories) {
        Log.info(item.toJson());
      }
      assert(categories != null);
      assert(categories.isNotEmpty);
      assert(categories.first.id.isNotEmpty);
    } catch (ex) {
      Log.error(ex);
      assert(false);
    }
  });
}
