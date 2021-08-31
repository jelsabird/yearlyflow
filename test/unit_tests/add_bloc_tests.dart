import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:yearly_flow/src/blocs/add_bloc.dart';
import 'package:yearly_flow/src/models/bullet_list_model.dart';
import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/note_model.dart';

import 'mock_classes.dart';

void inspirationAddBlocTests() {
  group("inspirationAddBloc", () {
    late InspirationAddBloc sut;
    late MockInspirationService mockInspirationService;
    late MockEventBus mockEventBus;

    setUp(() {
      mockInspirationService = MockInspirationService();
      mockEventBus = MockEventBus();

      sut = InspirationAddBloc(mockInspirationService, mockEventBus);
    });

    tearDown(() {
      reset(mockInspirationService);
    });

    test("should add model", () {
      sut.model = NoteModel();

      sut.add();

      verify(mockInspirationService.add(sut.model)).called(1);
    });

    test("should change to new inspiration type", () {
      sut.model = BulletListModel();

      for (InspirationType expectedType in InspirationType.values) {
        sut.changeTo(expectedType);

        expect(sut.model.inspirationType, expectedType);
      }
    });

  });
}