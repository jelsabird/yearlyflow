import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yearly_flow/service_locator.dart';
import 'package:yearly_flow/src/app.dart';
import 'package:yearly_flow/src/blocs/blocs.dart';
import 'package:yearly_flow/src/resources/repository.dart';

void main() {
  setupLocator();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (context) {
        return InspirationsBloc(
          repository: locator<IRepository>(),
        )..add(InspirationsLoaded());
      },
      child: YearlyFlowApp(),
    ),
  );
}
