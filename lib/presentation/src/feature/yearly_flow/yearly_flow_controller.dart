import 'package:yearly_flow/data/src/repository/data_controller.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/domain/src/entity/enums/month.dart';
import 'package:yearly_flow/presentation/src/entity/month_section.dart';

class YearlyFlowController {
  DataController _dataController = DataController.instance;

  final List<MonthSection> months = <MonthSection>[];
  final List<Inspiration> inspirations = <Inspiration>[];

  void init() {
    buildMonthList();
  }

  void buildMonthList() {
    for (final Month month in Month.values) {
      final MonthSection newMonth = MonthSection(month);
      months.add(newMonth);
    }
  }

  List<Inspiration> getMonthInspirations(int monthNumber) {
    final List<Inspiration> monthInspirations = inspirations
        .where((Inspiration inspiration) =>
            inspiration.month.monthNumber == monthNumber)
        .toList();

    _sortInspirations(monthInspirations);

    return monthInspirations;
  }

  void _sortInspirations(List<Inspiration> monthInspirations) {
    monthInspirations.sort((Inspiration a, Inspiration b) =>
        a.timeOfMonth.index.compareTo(b.timeOfMonth.index));
  }

  void loadInspirations() {
    var notes = _dataController.noteBox.values;
    var bulletLists = _dataController.bulletListBox.values;
    var recipes = _dataController.recipeBox.values;
    var birthdays = _dataController.birthdayBox.values;

    inspirations.clear();
    inspirations.addAll(notes);
    inspirations.addAll(bulletLists);
    inspirations.addAll(recipes);
    inspirations.addAll(birthdays);
  }

  void deleteInspiration(Inspiration inspiration){
    _dataController.delete(inspiration);
  }
}
