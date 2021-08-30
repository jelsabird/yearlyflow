import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:yearly_flow/src/blocs/inspiration_edit_bloc.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/note_model.dart';
import 'package:yearly_flow/src/ui/events/Inspiration_created_event.dart';
import 'package:yearly_flow/src/util/event_bus_utils.dart';

import 'mock_classes.dart';

void inspirationEditBlocTests() {
  group("inspirationEditBloc", () {
    late InspirationEditBloc sut;
    late MockDataController mockDataController;
    late NoteModel model;
    late StreamSubscription subscribtion;

    var eventFired = false;
    Month editedMonth = Month.January;

    setUp(() {
      mockDataController = MockDataController();
      model = NoteModel();

      sut = InspirationEditBloc(mockDataController, model);


      subscribtion = EventBusUtils.instance.on<CardUpdatedEvent>().listen(
              (event) {
            eventFired = true;
            editedMonth = event.month;
          });
    });

    tearDown(() {
      subscribtion.cancel();
      reset(mockDataController);
    });

    test("should save", () {
      sut.save();

      verify(mockDataController.save(model)).called(1);
      expect(sut.model.key, isNotNull);
    });

    test("should fire card updated event after save", () {


      sut.model.month = Month.April;
      sut.save();

      //expect(eventFired, isTrue);
      //expect(editedMonth, Month.April);
    });

  });
}