import 'package:rxdart/rxdart.dart';
import 'package:yearly_flow/service_locator.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/models/month_section.dart';
import 'package:yearly_flow/src/resources/repository.dart';

abstract class IInspirationListBloc {
  Stream<List<MonthSection>> get allInspirations;

  Future<void> fetchAllInspirations();

  delete(InspirationModel inspiration);

  dispose();
}

class InspirationListBloc implements IInspirationListBloc {
  InspirationListBloc(this._repository)
      : _inspirationsFetcher = PublishSubject<List<MonthSection>>();

  final IRepository _repository;
  final PublishSubject<List<MonthSection>> _inspirationsFetcher;

  Stream<List<MonthSection>> get allInspirations => _inspirationsFetcher.stream;

  Future<void> fetchAllInspirations() async {
    Stream.fromFuture(_repository.fetchAllInspirations())
        .map<List<InspirationModel>>((models) => _sortByTimeOfMonth(models))
        .map<List<MonthSection>>((models) => _mapToMonthSections(models))
        .listen((monthSections) {
      _inspirationsFetcher.sink.add(monthSections);
    });
  }

  List<InspirationModel> _sortByTimeOfMonth(List<InspirationModel> list) {
    list.sort((InspirationModel a, InspirationModel b) =>
        a.timeOfMonth.index.compareTo(b.timeOfMonth.index));
    return list;
  }

  List<MonthSection> _mapToMonthSections(List<InspirationModel> inspirations) {
    var monthSectionList = <MonthSection>[];
    for (Month month in Month.values) {
      var monthSection = MonthSection(month);
      monthSection.inspirations
          .addAll(inspirations.where((model) => model.month == month));
      monthSectionList.add(monthSection);
    }
    return monthSectionList;
  }

  void delete(InspirationModel inspiration) {
    _repository.delete(inspiration);
  }

  void dispose() {
    _inspirationsFetcher.close();
  }
}

final bloc = locator.get<IInspirationListBloc>();
