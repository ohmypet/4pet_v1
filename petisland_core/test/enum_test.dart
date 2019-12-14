import 'package:petisland_core/util/log.dart';
import 'package:petisland_core/util/petisland_constants.dart';
import 'package:test/test.dart';

void main() {
  test('Test category to string', () {
    CategoryTypeEnum.values.forEach((CategoryTypeEnum category) {
      final String str = enumToString(category);
      Log.debug('Category $category -> $str');
      expect(str, PetIslandConstants.categoryTypes[category.index]);
    });
  });
}
