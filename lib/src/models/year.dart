import 'package:equatable/equatable.dart';
import 'package:yearly_flow/src/models/models.dart';

class Year extends Equatable {

  final List<MonthSection> months;

  Year(this.months);

  @override
  List<Object?> get props => [months];

  InspirationModel getInspiration(String key) {
    for (var month in months) {
      var match = month.inspirations.where((inspiration) => inspiration
          .key == key);
      if (match.isNotEmpty) {
        return match.first;
      }
    }
    throw Exception("No inspiration found with key: $key");
  }

  addInspiration(InspirationModel inspiration) {
    var addToMonth = months.firstWhere((month) => month.month == inspiration
        .month);
    addToMonth.inspirations.add(inspiration);
    _sortByTimeOfMonth(addToMonth.inspirations);
  }

  updateInspiration(InspirationModel inspiration) {
    removeInspiration(inspiration.key);
    addInspiration(inspiration);
  }

  removeInspiration(String key) {
    var inspirationToRemove = getInspiration(key);
    var removeFromMonth = months.firstWhere((month) => month.month == inspirationToRemove
        .month);
    removeFromMonth.inspirations.remove(inspirationToRemove);
  }

  _sortByTimeOfMonth(List<InspirationModel> list) {
    list.sort((InspirationModel a, InspirationModel b) =>
        a.timeOfMonth.index.compareTo(b.timeOfMonth.index));
  }
}