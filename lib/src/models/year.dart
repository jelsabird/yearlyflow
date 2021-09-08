import 'package:equatable/equatable.dart';
import 'package:yearly_flow/src/models/models.dart';

class Year extends Equatable {

  final List<InspirationModel> inspirations;

  Year(this.inspirations);

  @override
  List<Object?> get props => [inspirations];

  InspirationModel getInspiration(String key) {
    return inspirations.firstWhere((inspiration) => inspiration
        .key == key);
  }

  List<MonthSection> getMonths() {
    var monthSectionList = <MonthSection>[];
    for (Month month in Month.values) {
      var monthSection = MonthSection(month);
      monthSection.inspirations
          .addAll(inspirations.where((model) => model.month == month));
      monthSectionList.add(monthSection);
    }
    return monthSectionList;
  }

  addInspiration(InspirationModel inspiration) {
    inspirations.add(inspiration);
    _sortByTimeOfMonth();
  }

  updateInspiration(InspirationModel inspiration) {
    removeInspiration(inspiration.key);
    addInspiration(inspiration);
  }

  removeInspiration(String key) {
    inspirations.removeWhere((inspiration) => inspiration.key == key);
  }

  _sortByTimeOfMonth() {
    inspirations.sort((InspirationModel a, InspirationModel b) =>
        a.timeOfMonth.index.compareTo(b.timeOfMonth.index));
  }
}