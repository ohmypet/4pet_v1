import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

///------------------------------------------------
/// `Event` for main app
///------------------------------------------------
abstract class MainAppEvent extends Equatable {
  MainAppEvent([List<dynamic> props = const <dynamic>[]])
      : super(<dynamic>[props]);

  @override
  String toString() => 'MainAppEvent';
}

class InitMainAppEvent extends MainAppEvent {
  @override
  String toString() => 'InitMainAppEvent';
}

class CompletedInitMainAppEvent extends MainAppEvent {
  @override
  String toString() => 'CompletedInitMainAppEvent';
}

///------------------------------------------------
/// State for main app
///------------------------------------------------
abstract class MainAppState extends Equatable {
  MainAppState([List<dynamic> props = const <dynamic>[]])
      : super(<dynamic>[props]);

  @override
  String toString() => 'MainAppState';
}

class InitMainAppState extends MainAppState {
  @override
  String toString() => 'InitMainAppState';
}

class CompletedInitMainAppState extends MainAppState {
  @override
  String toString() => 'CompletedInitMainAppState';
}

///------------------------------------------------
/// Define bloc
///------------------------------------------------

class MainAppBloc extends Bloc<MainAppEvent, MainAppState> {
  @override
  MainAppState get initialState => InitMainAppState();

  @override
  Stream<MainAppState> mapEventToState(MainAppEvent event) async* {
    switch (event.runtimeType) {
      case InitMainAppEvent:
        yield InitMainAppState();
        break;
      case CompletedInitMainAppEvent:
        yield CompletedInitMainAppState();
        break;
      default:
    }
  }
}
