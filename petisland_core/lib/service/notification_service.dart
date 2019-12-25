part of petisland_core.service;

abstract class NotificationService {
  Future<List<Notification>> getNotifications({int offset, int limit});
  Future<Notification> readNotification(String id);
}

class NotificationServiceImpl extends NotificationService {
  @protected
  final NotificationRepository repository;

  NotificationServiceImpl(this.repository);
  @override
  Future<List<Notification>> getNotifications({int offset, int limit}) {
    return repository.getNotifications(offset: offset, limit: limit);
  }

  @override
  Future<Notification> readNotification(String id) {
    return repository.readNotification(id);
  }
}
