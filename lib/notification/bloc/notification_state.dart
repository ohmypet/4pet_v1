part of petisland.notification.bloc;

abstract class NotificationState extends BaseState {}

class ReloadNotificationUI extends NotificationState {
  final List<PetNotification> items;

  ReloadNotificationUI(this.items);

  @override
  String toString() => '$runtimeType-${items.length}';
}

class InitNotificationState extends NotificationState {}
