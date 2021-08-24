import 'package:rxdart/rxdart.dart';
import 'package:yearly_flow/src/models/month_section_model.dart';
import 'package:yearly_flow/src/resources/repository.dart';

class InspirationsBloc {
  final Repository _repository = Repository();
  final PublishSubject<MonthSectionModel> _inspirationsFetcher =
  PublishSubject<MonthSectionModel>();

  Stream<MonthSectionModel> get allInspirations => _inspirationsFetcher.stream;

  fetchAllInspirations() async {
    MonthSectionModel monthSectionModel = await _repository
        .fetchAllInspirations();
    _inspirationsFetcher.sink.add(monthSectionModel);
  }

  dispose() {
    _inspirationsFetcher.close();
  }
}

final bloc = InspirationsBloc();