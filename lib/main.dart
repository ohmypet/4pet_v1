import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/main_bloc/main_app_bloc.dart';
import 'package:flutter_template/petisland.dart';
import 'package:petisland_core/petisland_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final MainAppBloc bloc = MainAppBloc();

  Log.debug('this is main');

  handleError();
  runZoned(() {
    runApp(buildApp(bloc));
  }, onError: (dynamic ex, dynamic trace) {
    Crashlytics.instance.recordError(ex, trace);
  });
  // Future.delayed(const Duration(seconds: 5)).then((_) {
  //   bloc.dispatch(InitMainAppEvent());
  // });
}

void initAsync(MainAppBloc bloc) async {
  Log.debug('this is initAsync');
  // await Future.delayed(const Duration(seconds: 5));
  final Mode mode = kReleaseMode ? Mode.Production : Mode.Debug;
  final List<Module> modules = kReleaseMode ? <Module>[ProdModule()] : <Module>[DevModule()];

  Config.initAsync(mode)
      .then((_) => DI.initAsync(modules))
      .catchError((dynamic ex) => Log.error(ex))
      .whenComplete(() => bloc.dispatch(CompletedInitMainAppEvent()));
  // .then((_) => bloc.dispatch(CompletedInitMainAppEvent()));
}

void handleError() {
  FlutterError.onError = (FlutterErrorDetails error) {
    FlutterError.dumpErrorToConsole(error);
    Zone.current.handleUncaughtError(error.exception, error.stack);
  };
  if (!kReleaseMode) {
    BlocSupervisor.delegate = TBlocDelegate();
  }
}

Widget buildApp(MainAppBloc bloc) {
  final Widget child = blocBuilder(buildMainApp(), bloc);
  return MaterialApp(
    home: BlocProvider<MainAppBloc>(
      builder: (_) => bloc,
      child: child,
    ),
  );
}

Widget blocBuilder(Widget child, MainAppBloc bloc) {
  return BlocBuilder<MainAppBloc, MainAppState>(
    bloc: bloc,
    builder: (_, MainAppState state) {
      Log.debug('bloc_Bulder $state');
      switch (state.runtimeType) {
        case InitMainAppState:
          return buildSplashScreen();
          break;
        case CompletedInitMainAppState:
          return child;
        default:
          return child;
      }
    },
  );
}

Widget buildSplashScreen() {
  return Scaffold(
    backgroundColor: TColors.white,
    body: Center(
      child: Image.network('https://github.com/tvc12.png'),
      // child: Text(
      //   'Slash Screen',
      //   style: TTextStyles.bold(
      //     fontSize: 150,
      //     color: TColors.green,
      //   ),
      // ),
    ),
  );
}

Widget buildMainApp() {
  return Scaffold(
    backgroundColor: TColors.white,
    body: Center(
      child: Text(
        'Main Screen',
        style: TTextStyles.bold(
          fontSize: 150,
          color: TColors.black,
        ),
      ),
    ),
  );
}
