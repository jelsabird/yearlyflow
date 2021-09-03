import 'package:get_it/get_it.dart';
import 'package:yearly_flow/src/resources/data_provider.dart';
import 'package:yearly_flow/src/resources/repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<IDataProvider>(
      () => DataProvider.instance);
  locator.registerLazySingleton<IRepository>(
      () => Repository(locator<IDataProvider>()));
}
