import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yearly_flow/src/blocs/inspiration_list_bloc.dart';
import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/item_model.dart';
import 'package:yearly_flow/src/models/note_model.dart';

import 'mock_classes.dart';

void inspirationListBlocTests() {
  group("InspirationListBloc", () {
    late InspirationListBloc sut;
    late FakeRepository fakeRepository;
    late MockRepository mockRepository;

    setUp(() {
      fakeRepository = FakeRepository();
      mockRepository = MockRepository();

      sut = InspirationListBloc(fakeRepository, PublishSubject<ItemModel>());
    });

    tearDown(() {
      reset(mockRepository);
    });

    test("should fetch all inspirations", () async {
      await sut.fetchAllInspirations();

      expect(sut.monthMap.values.length, 4);
    });

    // Test data defined in FakeRepository class
    test("should map inspirations to months", () async {
      await sut.fetchAllInspirations();

      expect(sut.monthMap[Month.January]!.length, 1);
      expect(sut.monthMap[Month.February]!.length, 2);
      expect(sut.monthMap[Month.March]!.length, 1);
      expect(sut.monthMap[Month.November]!.length, 1);

      expect(InspirationType.Note, sut.monthMap[Month.January]!.first
          .inspirationType);
      expect(InspirationType.Note, sut.monthMap[Month.February]!.first
          .inspirationType);
      expect(InspirationType.Recipe, sut.monthMap[Month.March]!.first
          .inspirationType);
      expect(InspirationType.Birthday, sut.monthMap[Month.November]!.first
          .inspirationType);
    });

    test("should delete", () {
      sut = InspirationListBloc(mockRepository, PublishSubject<ItemModel>());

      var modelToDelete = NoteModel();
      sut.delete(modelToDelete);

      verify(mockRepository.delete(modelToDelete)).called(1);
    });
  });
}
