import 'package:petisland_core/util/log.dart';
import 'package:petisland_core/util/petisland_constants.dart';
import 'package:test/test.dart';

void main() {
  test("Test category to string", () {
    CategoryEnum.values.forEach((CategoryEnum category) {
      final String str = enumToString(category);
      Log.debug("Category $category -> $str");
      expect(str, PetIslandConstants.categories[category.index]);
    });
  });
}
