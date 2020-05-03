part of petisland_core.service;

abstract class NotificationService {
  Future<List<PetNotification>> getNotifications({int offset, int limit});
  Future<PetNotification> readNotification(String id);
}

class NotificationServiceImpl extends NotificationService {
  @protected
  final NotificationRepository repository;

  NotificationServiceImpl(this.repository);
  @override
  Future<List<PetNotification>> getNotifications({int offset, int limit}) {
    return repository.getNotifications(offset: offset, limit: limit);
  }

  @override
  Future<PetNotification> readNotification(String id) {
    return repository.readNotification(id);
  }
}
