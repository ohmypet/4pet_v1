import 'package:flutter_driver/flutter_driver.dart';

class BaseTest {
  FlutterDriver driver;
  BaseTest(this.driver);

  Future<void> input(String key, String text) async {
    final SerializableFinder finder = findKey(key);
    await driver.tap(finder);
    await driver.enterText(text);
  }

  Future<void> inputFinder(SerializableFinder finder, String text) async {
    await driver.tap(finder);
    await driver.enterText(text);
  }

  Future<void> click(String key) async {
    final SerializableFinder finder = findKey(key);
    await driver.tap(finder);
  }

  Future<void> clickText(String text) async {
    final SerializableFinder finder = findText(text);
    await driver.tap(finder);
  }

  Future<void> clickFinder(SerializableFinder finder) async {
    await driver.tap(finder);
  }

  Future<void> scrollX(String key) async {
    await driver.scroll(findKey(key), -1000, 0, Duration(milliseconds: 100));
  }

  Future<void> scrollVertical(String key, {double dy = -1000}) async {
    await driver.scroll(findKey(key), 0, dy, Duration(milliseconds: 100));
  }

  Future<void> scrollVerticalWitget(String widgetName, {double dy = -1000}) async {
    await driver.scroll(
        findWidget(widgetName), 0, dy, Duration(milliseconds: 100));
  }

  SerializableFinder findKey(String key) {
    return find.byValueKey(key);
  }

  SerializableFinder findText(String text) {
    return find.text(text);
  }

  SerializableFinder findWidget(String widget) {
    return find.byType(widget.toString());
  }
}
