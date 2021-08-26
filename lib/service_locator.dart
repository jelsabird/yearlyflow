import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:yearly_flow/src/blocs/inspiration_add_bloc.dart';
import 'package:yearly_flow/src/blocs/inspiration_edit_bloc.dart';
import 'package:yearly_flow/src/blocs/inspiration_list_bloc.dart';
import 'package:yearly_flow/src/blocs/splash_bloc.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/models/item_model.dart';
import 'package:yearly_flow/src/resources/data_controller.dart';
import 'package:yearly_flow/src/resources/repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<IDataController>(() => DataController.instance);
  locator.registerLazySingleton<IRepository>(() => Repository(locator<IDataController>()));

  locator.registerFactory<IInspirationAddBloc>(
      () => InspirationAddBloc(locator<IDataController>(), Uuid()));
  locator.registerFactoryParam<IInspirationEditBloc, InspirationModel, void>(
          (model, param2) => InspirationEditBloc(locator<IDataController>(),
              model));
  locator.registerFactory<IInspirationListBloc>(
      () => InspirationsBloc(locator<IRepository>(), PublishSubject<ItemModel>
        ()));
  locator.registerFactory<ISplashBloc>(() => SplashBloc(locator<IDataController>()));
}
