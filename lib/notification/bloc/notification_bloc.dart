part of petisland.notification.bloc;

class NotificationBloc extends TBloc<NotificationEvent, NotificationState> {
  static final NotificationService service = DI.get(NotificationService);
  final List<PetNotification> notifications = [];
  final int limit = 15;
  @protected
  Timer timer;

  @protected
  int get offset => notifications.length;

  @override
  Duration get delayEvent => const Duration(milliseconds: 150);

  @override
  Stream<NotificationState> errorToState(BaseErrorEvent event) {
    return null;
  }

  @override
  Stream<NotificationState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case ReloadNotificationEvent:
        _reloadNotification(event);
        break;
      case RetrieveNotificationEvent:
        _retrieveNotification(event);
        break;
      case RequireReloadUIEvent:
        yield ReloadNotificationUI((event as RequireReloadUIEvent).items);
        break;
      default:
    }
  }

  void _reloadNotification(ReloadNotificationEvent event) {
    FutureOr updateNotifications(List<PetNotification> items) {
      if (items.isNotEmpty) {
        notifications
          ..clear()
          ..addAll(items);
      }

      add(RequireReloadUIEvent(notifications));
    }

    service
        .getNotifications(offset: event.offset, limit: event.limit)
        .then(updateNotifications)
        .catchError((ex) => Log.error(ex));
  }

  void _retrieveNotification(RetrieveNotificationEvent event) {
    FutureOr updateNotifications(List<PetNotification> items) {
      if (items.isNotEmpty) {
        notifications.addAll([...?items]);
      }

      add(RequireReloadUIEvent(notifications));
    }

    service
        .getNotifications(offset: event.offset, limit: event.limit)
        .then(updateNotifications)
        .catchError((ex) => Log.error(ex));
  }

  @override
  NotificationState get initialState => InitNotificationState();

  void _getNotification() {
    add(ReloadNotificationEvent(offset, limit));
  }

  void retrieveNotification() {
    add(RetrieveNotificationEvent(offset, limit));
  }

  void startListener() {
    _getNotification();
//     timer = Timer.periodic(const Duration(seconds: 10), (_) => _getNotification());
  }

  void stopListener() {
    if (timer?.isActive == true) {
      timer.cancel();
    }
  }
}
