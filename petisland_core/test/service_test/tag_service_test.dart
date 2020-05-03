import 'package:flutter_test/flutter_test.dart';
import 'package:petisland_core/petisland_core.dart';

import 'configuration.dart';

void main() async {
  await setupEnvironment();
  login();

  final TagService service = DI.get<TagService>(TagService);
  test('Get tags with title is empty', () async {
    try {
      final List<Tag> tags = await service.getTags('');
      for (Tag item in tags) {
        Log.info(item.toJson());
      }
      expect(tags, isNotNull);
    } catch (ex) {
      Log.info(ex);
      assert(false);
    }
  });
  test('Get tags with title is null', () async {
    try {
      final List<Tag> tags = await service.getTags(null);
      for (Tag item in tags) {
        Log.info(item.toJson());
      }
      expect(tags, isNotNull);
    } catch (ex) {
      Log.info(ex);
      assert(false);
    }
  });
  test('Get tags with title dog', () async {
    try {
      final List<Tag> tags = await service.getTags('dog');
      for (Tag item in tags) {
        Log.info(item.toJson());
      }
      expect(tags, isNotNull);
    } catch (ex) {
      Log.info(ex);
      assert(false);
    }
  });
}
