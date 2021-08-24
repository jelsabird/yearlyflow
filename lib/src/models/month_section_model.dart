import 'package:yearly_flow/domain/src/entity/enums/month.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';

class MonthSectionModel {
  late Month _month;
  late int _cardsCount;
  List<Inspiration> _inspirationCards = [];

  Month get month => _month;
  int get cardsCount => _cardsCount;
  List<Inspiration> get inspirationCards => _inspirationCards;
}