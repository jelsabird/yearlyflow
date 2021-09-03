import 'package:flutter_test/flutter_test.dart';
import 'package:yearly_flow/service_locator.dart';

void main() {

  group("Unit tests", () {

    setUpAll(() {
      setupLocator();
      locator.allowReassignment = true;
    });
  });
}
