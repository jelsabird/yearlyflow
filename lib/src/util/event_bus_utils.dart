import 'package:event_bus/event_bus.dart';

abstract class IEventBus {
  static EventBus instance = EventBus();
}

class EventBusUtils extends EventBus implements IEventBus {
  static EventBus instance = EventBus();
}
