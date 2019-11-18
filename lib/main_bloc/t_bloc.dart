part of petisland.main_bloc;

abstract class TBloc<Event extends BaseEvent, State extends BaseState>
    extends BaseBloc<Event, State> {
  @protected
  Duration get delayEvent;

  @override
  Stream<State> transformEvents(Stream<Event> events, Stream<State> Function(Event event) next) {
    final Observable<Event> eventsObservable = events;
    return eventsObservable.debounceTime(delayEvent).switchMap(next);
  }
}

abstract class BaseBloc<Event extends BaseEvent, State extends BaseState>
    extends Bloc<BaseEvent, BaseState> {
  Stream<BaseState> mapEventToState(BaseEvent event) {
      Log.debug("event ${event.runtimeType}");
    if (event is BaseErrorEvent) {
      final Stream<BaseState> baseState = errorToState(event);
      return baseState;
    } else {
      return eventToState(event);
    }
  }

  Stream<BaseErrorState> errorToState(BaseErrorEvent event);

  Stream<State> eventToState(BaseEvent event);

  void notifyError(BaseErrorEvent event) {
    final BaseEvent baseEvent = event;
    add(baseEvent);
  }

  @protected
  void add(BaseEvent event) => super.add(event);
}

@immutable
abstract class BaseEvent {
  @override
  String toString() => "$runtimeType";
}

@immutable
abstract class BaseState {
  @override
  String toString() => "$runtimeType";
}

abstract class BaseErrorEvent extends BaseEvent {
  final String message;

  factory BaseErrorEvent([String message]) => _BaseErrorEvent(message);

  @override
  String toString() => "$runtimeType $message";
}

class _BaseErrorEvent implements BaseErrorEvent {
  final String message;

  _BaseErrorEvent(this.message);
}

abstract class BaseErrorState extends BaseState {
  final String message;

  factory BaseErrorState([String message]) => _BaseErrorState(message);

  @override
  String toString() => "$runtimeType $message";
}

class _BaseErrorState implements BaseErrorState {
  final String message;

  _BaseErrorState(this.message);
}
