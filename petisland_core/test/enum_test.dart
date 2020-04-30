import 'package:flutter_test/flutter_test.dart';
import 'package:petisland_core/utils/utils.dart';

void main() {
  test('Test category to string', () {
    CategoryTypeEnum.values.forEach((CategoryTypeEnum category) {
      final String str = enumToString(category);
      Log.debug('Category $category -> $str');
      expect(str, PetIslandConstants.categoryTypes[category.index]);
    });
  });
}
