import 'package:flutter_test/flutter_test.dart';
import 'package:yearly_flow/service_locator.dart';
import 'unit_tests/inspiration_edit_bloc_tests.dart';
import 'unit_tests/inspiration_list_bloc_tests.dart';
import 'unit_tests/inspiration_add_bloc_tests.dart';
import 'unit_tests/splash_bloc_tests.dart';

void main() {

  group("Unit tests", () {

    setUpAll(() {
      setupLocator();
      locator.allowReassignment = true;
    });

    splashBlocTests();
    inspirationListBlocTests();
    inspirationAddBlocTests();
    inspirationEditBlocTests();
  });
}
