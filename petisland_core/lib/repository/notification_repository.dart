part of petisland_core.repository;

abstract class NotificationRepository {
  Future<List<Notification>> getNotifications({int offset, int limit});
  Future<Notification> readNotification(String id);
}

class NotificationRepositoryImpl extends NotificationRepository {
  @protected
  final HttpClient client;

  NotificationRepositoryImpl(this.client);

  @override
  Future<List<Notification>> getNotifications({int offset, int limit}) {
    final Map<String, int> params = {
      'offset': offset,
      'limit': limit,
    };
    return client
        .get<List<dynamic>>('/api/notification', params: params)
        .then(_parseToNotifications);
  }

  @override
  Future<Notification> readNotification(String id) {
    return client.put<Map<String, dynamic>>(
        '/api/notification/$id', {}).then((json) => Notification.fromJson(json));
  }

  FutureOr<List<Notification>> _parseToNotifications(List items) {
    return items
        .cast<Map<String, dynamic>>()
        .map((json) => Notification.fromJson(json))
        .toList();
  }
}
