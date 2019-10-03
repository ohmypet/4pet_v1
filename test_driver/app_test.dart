import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Automation Test", () {
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() {
      if (driver != null) {
        driver.close();
      }
    });
    test("Test flow", () async {
      await mainFlow(driver);
    }, timeout: Timeout(const Duration(hours: 1)));
  });
}

Future<void> mainFlow(FlutterDriver driver) async {}
