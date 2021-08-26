import 'package:yearly_flow/src/models/enums/month.dart';

class CardUpdatedEvent {
  CardUpdatedEvent(this.month);

  Month month;
}