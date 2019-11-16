part of petisland.main_bloc;

class TBlocDelegate extends BlocDelegate {
  @override
  //ignore: always_specify_types
  void onEvent(final Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    Log.debug('${bloc.runtimeType}: $event');
  }

  @override
  //ignore: always_specify_types
  void onTransition(final Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Log.debug('${bloc.runtimeType}: $transition');
  }

  @override
  //ignore: always_specify_types
  void onError(final Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    Log.debug(error);
    Log.debug(stacktrace);
  }
}
