import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:yearly_flow/src/blocs/edit_bloc.dart';
import 'package:yearly_flow/src/models/note_model.dart';

import 'mock_classes.dart';

void inspirationEditBlocTests() {
  group("inspirationEditBloc", () {
    late InspirationEditBloc sut;
    late NoteModel model;
    late MockInspirationService mockInspirationService;
    late MockEventBus mockEventBus;

    setUp(() {
      mockInspirationService = MockInspirationService();
      model = NoteModel();
      mockEventBus = MockEventBus();

      sut = InspirationEditBloc(model, mockInspirationService, mockEventBus);
    });

    tearDown(() {
      reset(mockInspirationService);
    });

    test("should update", () {
      sut.update();

      verify(mockInspirationService.update(sut.model)).called(1);
      expect(sut.model.key, isNotNull);
    });

    test("should fire card updated event after update", () {
      sut.update();

      verify(mockEventBus.fire(captureAny)).called(1);
    });
  });
}
