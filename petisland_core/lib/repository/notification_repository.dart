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

class NotificationRepositoryFake extends NotificationRepository {
  @protected
  final HttpClient client;

  NotificationRepositoryFake(this.client);

  @override
  Future<List<PetNotification>> getNotifications({int offset, int limit}) async {
    return List.generate(
      limit,
      (index) => _randomNotifications(),
    );
  }

  final Random random = Random();

  final items = [
    'Bài viết @{Sell a cute dog} đã bị xóa vì lý do @{Phân biệt chủng tộc, Gây nhầm lẫn, Spam, Phân biệt giới tính, Bạo lực}',
    '@{Nguyen Duy Cuong} da thich bai viet @{Ban cho meo}',
    '@{Nguyen Duy Cuong} da binh luan bai viet @{Ban cho meo}',
    '@{Cuong} da binh luan bai viet @{Ban cho meo}'
  ];

  @override
  Future<PetNotification> readNotification(String id) async {
    return _randomNotifications();
  }

  PetNotification _randomNotifications() {
    return PetNotification(
      ThinId.randomId(),
      DateTime.now(),
      DateTime.now(),
      null,
      sender: Account(
        id: ThinId.randomId(),
        username: 'admin',
        user: User(
          id: ThinId.randomId(),
          name: 'Nguyen Duy Cuong',
          avatar: PetImage(url: 'https://github.com/tvc12.png'),
          phoneNumber: '0966144938',
        ),
      ),
      isRead: random.nextBool(),
      message: items[random.nextInt(items.length)],
    );
  }
}
