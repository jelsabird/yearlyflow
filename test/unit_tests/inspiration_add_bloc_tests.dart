import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'package:yearly_flow/src/blocs/inspiration_add_bloc.dart';
import 'package:yearly_flow/src/models/bullet_list_model.dart';
import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/note_model.dart';

import 'mock_classes.dart';

void inspirationAddBlocTests() {
  group("inspirationAddBloc", () {
    late InspirationAddBloc sut;
    late MockDataController mockDataController;

    setUp(() {
      mockDataController = MockDataController();

      sut = InspirationAddBloc(mockDataController, Uuid());
    });

    tearDown(() {
      reset(mockDataController);
    });

    test("should save model with key", () {
      sut.model = NoteModel();

      sut.save();

      verify(mockDataController.save(sut.model)).called(1);
      expect(sut.model.key, isNotNull);
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