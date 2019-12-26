part of petisland_core.repository;

abstract class NotificationRepository {
  Future<List<PetNotification>> getNotifications({int offset, int limit});
  Future<PetNotification> readNotification(String id);
}

class NotificationRepositoryImpl extends NotificationRepository {
  @protected
  final HttpClient client;

  NotificationRepositoryImpl(this.client);

  @override
  Future<List<PetNotification>> getNotifications({int offset, int limit}) {
    final Map<String, int> params = {
      'offset': offset,
      'limit': limit,
    };
    return client
        .get<List<dynamic>>('/api/notification', params: params)
        .then(_parseToNotifications);
  }

  @override
  Future<PetNotification> readNotification(String id) {
    return client.put<Map<String, dynamic>>(
        '/api/notification/$id', {}).then((json) => PetNotification.fromJson(json));
  }

  FutureOr<List<PetNotification>> _parseToNotifications(List items) {
    return items
        .cast<Map<String, dynamic>>()
        .map((json) => PetNotification.fromJson(json))
        .toList();
  }
}
