part of petisland.notification.bloc;

abstract class NotificationEvent extends BaseEvent {}

class ReloadNotificationEvent extends NotificationEvent {
  final int offset;
  final int limit;

  ReloadNotificationEvent(this.offset, this.limit);
}

class RequireReloadUIEvent extends NotificationEvent {
  final List<PetNotification> items;

  RequireReloadUIEvent(this.items);
}

class RetrieveNotificationEvent extends NotificationEvent {
  final int offset;
  final int limit;

  RetrieveNotificationEvent(this.offset, this.limit);
}

class ReadNotification extends NotificationEvent {
  final String id;

  ReadNotification(this.id);
}
