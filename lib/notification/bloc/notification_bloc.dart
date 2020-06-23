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
      case ReadNotification:
        stopListener();
        _readNotification(event);
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

  void getNotification() {
    add(ReloadNotificationEvent(0, limit));
  }

  void retrieveNotification() {
    add(RetrieveNotificationEvent(offset, limit));
  }

  void startListener() {
    getNotification();
    if (timer?.isActive == true) timer.cancel();
    timer = Timer.periodic(const Duration(seconds: 3), (_) => getNotification());
  }

  void clear() {
    notifications.clear();
  }

  void readNotification(String id) {
    add(ReadNotification(id));
  }

  void stopListener() {
    if (timer?.isActive == true) {
      timer.cancel();
    }
  }

  void _readNotification(ReadNotification event) {
    service.readNotification(event.id).then((_) {
      Log.info('readNotification:: success');
      startListener();
    }).catchError((_, __) {
      Log.info('readNotification:: failure $__');
      startListener();
    });
  }
}
