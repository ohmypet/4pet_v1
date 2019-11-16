part of petisland.main_bloc;

class TBlocDelegate extends BlocDelegate {
  @override
  //ignore: must_call_super
  void onEvent(final Bloc<dynamic, dynamic> bloc, Object event) {
    Log.debug('${bloc.runtimeType}: $event');
  }

  @override
  //ignore: must_call_super
  void onTransition(final Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    Log.debug('${bloc.runtimeType}: $transition');
  }

  @override
  //ignore: must_call_super
  void onError(final Bloc<dynamic, dynamic> bloc, Object error, StackTrace stacktrace) {
    Log.debug(error);
    Log.debug(stacktrace);
  }
}
