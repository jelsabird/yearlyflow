import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:yearly_flow/data/src/repository/inspiration_data_controller.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/domain/src/entity/enums/month.dart';
import 'package:yearly_flow/presentation/src/entity/month_section.dart';

class YearlyFlowController {
  late InspirationDataController dataController;

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

  Future<void> loadInspirations() async {
    dataController = InspirationDataController();
    final List<Inspiration> result = await dataController.readJson();

    inspirations.clear();
    inspirations.addAll(result);
  }
}
