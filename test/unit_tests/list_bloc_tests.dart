import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yearly_flow/src/blocs/list_bloc.dart';
import 'package:yearly_flow/src/models/note_model.dart';

import 'mock_classes.dart';

void inspirationListBlocTests() {
  group("InspirationListBloc", () {
    late InspirationListBloc sut;
    late MockRepository mockRepository;

    setUp(() {
      mockRepository = MockRepository();

      sut = InspirationListBloc(mockRepository);
    });

    tearDown(() {
      reset(mockRepository);
    });

    //test("should fetch all inspirations", () async {
      //await sut.fetchAllInspirations();

      //verify(mockRepository.fetchAllInspirations()).called(1);
    //});

    test("should delete", () {
      var modelToDelete = NoteModel();

      sut.delete(modelToDelete);

      verify(mockRepository.delete(modelToDelete)).called(1);
    });
  });
}
