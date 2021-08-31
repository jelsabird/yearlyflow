import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:yearly_flow/src/blocs/add_bloc.dart';
import 'package:yearly_flow/src/blocs/edit_bloc.dart';
import 'package:yearly_flow/src/blocs/list_bloc.dart';
import 'package:yearly_flow/src/blocs/splash_bloc.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/resources/inspiration_service.dart';
import 'package:yearly_flow/src/resources/repository.dart';
import 'package:yearly_flow/src/util/event_bus_utils.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<EventBus>(() => EventBusUtils.instance);
  locator.registerLazySingleton<IInspirationService>(
      () => InspirationService.instance);
  locator.registerLazySingleton<IRepository>(
      () => Repository(locator<IInspirationService>()));

  locator.registerFactory<IInspirationAddBloc>(() =>
      InspirationAddBloc(locator<IInspirationService>(), locator<EventBus>()));
  locator.registerFactoryParam<IInspirationEditBloc, InspirationModel, void>(
      (model, param2) => InspirationEditBloc(
          model, locator<IInspirationService>(), locator<EventBus>()));
  locator.registerFactory<IInspirationListBloc>(() =>
      InspirationListBloc(locator<IRepository>()));
  locator.registerFactory<ISplashBloc>(
      () => SplashBloc(locator<IInspirationService>()));
}
