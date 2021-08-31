import 'package:event_bus/event_bus.dart';
import 'package:mockito/mockito.dart';
import 'package:yearly_flow/src/resources/inspiration_service.dart';
import 'package:yearly_flow/src/resources/repository.dart';

class MockInspirationService extends Mock implements IInspirationService {}
class MockRepository extends Mock implements IRepository {}
class MockEventBus extends Mock implements EventBus {}
