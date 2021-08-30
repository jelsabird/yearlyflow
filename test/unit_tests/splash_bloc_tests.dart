import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:yearly_flow/src/blocs/splash_bloc.dart';

import 'mock_classes.dart';

void splashBlocTests() {
  group("splahBloc", () {
    late SplashBloc sut;
    late MockDataController mockDataController;

    setUp(() {
      mockDataController = MockDataController();

      sut = SplashBloc(mockDataController);
    });

    tearDown(() {
      reset(mockDataController);
    });

    // TODO: mock initDatabase return value
    //test("should initialize database", () async {
      //await sut.init();

      //verify(mockDataController.initDatabase());
    //});

  });
}