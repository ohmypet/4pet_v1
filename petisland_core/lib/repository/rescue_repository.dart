part of petisland_core.repository;

class MockRescueRepository extends RescueRepository {
  static final images = [
    'https://github.com/tvc12.png',
    'https://http.cat/100',
    'https://http.cat/101',
    'https://http.cat/200',
    'https://http.cat/201',
    'https://http.cat/202',
    'https://http.cat/204',
    'https://http.cat/206',
    'https://http.cat/207',
    'https://http.cat/300',
    'https://http.cat/301',
    'https://http.cat/302',
    'https://http.cat/303',
    'https://http.cat/304',
    'https://http.cat/305',
  ];

  static final ran = Random();

  static Account get account => Account(
        id: ThinId.randomId(),
        createAt: DateTime.now(),
        createBy: null,
        email: '${ThinId.randomId()}@gmail.com',
        role: 'Admin',
        settings: {},
        status: 'Active',
        username: ThinId.randomId(),
        user: user,
      );
  static PetImage get avatar => PetImage(id: ThinId.randomId(), url: image);

  static Comment get comment => Comment(
        createAt: DateTime.now(),
        message: ThinId.randomId(numberCharacter: 5),
        createBy: account,
      );

  static String get image {
    return images[ran.nextInt(images.length - 1)];
  }

  static User get user => User(
        id: ThinId.randomId(),
        name: ThinId.randomId(numberCharacter: 5),
        phoneNumber: '0966144938',
        avatar: avatar,
      );

  final titles = <String>[
    'Cần sự trợ giúp để cứu một chú mèo đang gặp nạn',
    'Giúp mình cứu một con chó đang ngủ',
    'Cần tìm người chữa bệnh cho chó của mình',
    'Cần tìm người để giải cứu mèo đang bị kẹt ở trên cao',
  ];

  final comments = List.generate(ran.nextInt(12), (index) => comment);
  List<String> get listImage {
    final size = ran.nextInt(images.length - 1);
    return images.toList().sublist(0, size)..shuffle();
  }

  Rescue get rescue => Rescue(
        id: ThinId.randomId(),
        account: account,
        likes: ran.nextInt(1000),
        isJoined: ran.nextBool(),
        location: 'Dong Nai, VietNam',
        description: 'Can ban gap con choa',
        rescueImages: rescueImages,
        title: title,
        maxHeroes: ran.nextInt(10),
        totalCoin: ran.nextInt(15000).toDouble(),
        currentHeroes: ran.nextInt(10),
        status: 'Active',
        createAt: DateTime.now(),
        isReacted: ran.nextBool(),
      );

  List<RescueImage> get rescueImages {
    final size = ran.nextInt(10);
    return List.generate(
      size,
      (_) => RescueImage(id: ThinId.randomId(), image: avatar),
    );
  }

  String get title => titles[ran.nextInt(titles.length - 1)];

  @override
  Future<Rescue> create(Rescue rescue, List<String> images) {
    return Future.value(rescue);
  }

  @override
  Future<List<Comment>> getComments(String id) {
    return Future.value(comments);
  }

  @override
  Future<List<RescueDonate>> getDonaters(String id) {
    return Future.value(
      List.generate(
        ran.nextInt(20),
        (index) => RescueDonate(
          id: ThinId.randomId(),
          coin: ran.nextInt(1000) + ran.nextInt(100),
          account: account,
          createAt: DateTime.now(),
        ),
      ),
    );
  }

  @override
  Future<List<RescueAccount>> getHeroJoined(String id) {
    return Future.value(
      List.generate(
        ran.nextInt(12),
        (index) => RescueAccount(
          id: ThinId.randomId(),
          hero: account,
          status: ThinId.randomId(numberCharacter: 5),
          createAt: DateTime.now(),
        ),
      ),
    );
  }

  @override
  Future<bool> join(String id) {
    return Future.value(true);
  }

  @override
  Future<bool> like(String id) {
    return Future.value(true);
  }

  @override
  Future<List<Rescue>> search(int from, int limit) async {
    final size = ran.nextInt(20);
    return List.generate(size, (_) => rescue);
  }

  @override
  Future<bool> unJoin(String id) {
    return Future.value(true);
  }

  @override
  Future<Rescue> update(Rescue rescue) {
    return Future.value(rescue);
  }

  @override
  Future<bool> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Rescue> edit(Rescue id, List<String> newImages, List<String> oldImages) {
    throw UnimplementedError();
  }
}

abstract class RescueRepository {
  Future<Rescue> create(Rescue rescue, List<String> images);
  Future<Rescue> edit(Rescue rescue, List<String> newImages, List<String> oldImages);
  Future<bool> delete(String id);

  Future<List<Comment>> getComments(String id);
  Future<List<RescueDonate>> getDonaters(String id);

  Future<List<RescueAccount>> getHeroJoined(String id);
  Future<bool> join(String id);

  Future<bool> like(String id);

  Future<List<Rescue>> search(int from, int limit);
  Future<bool> unJoin(String id);
  Future<Rescue> update(Rescue rescue);

  // Future<List<Hero
}

class RescueRepositoryImpl extends RescueRepository {
  @protected
  final HttpClient client;

  RescueRepositoryImpl(this.client);

  @override
  Future<Rescue> create(Rescue rescue, List<String> images) {
    final body = {
      ...rescue.toJson(),
      'imagesId': images,
    }..removeWhere((key, value) => value == null);

    return client
        .post<Map<String, dynamic>>('/rescue-service/rescue-posts', body)
        .then((json) => Rescue.fromJson(json));
  }

  @override
  Future<bool> delete(String id) {
    return client
        .delete<Map<String, dynamic>>('/rescue-service/rescue-posts/${id}')
        .then((json) => Rescue.fromJson(json))
        .then((value) => value != null);
  }

  @override
  Future<Rescue> edit(Rescue id, List<String> newImages, List<String> oldImages) {
    final body = {};
    return client
        .put<Map<String, dynamic>>('/rescue-service/rescue-posts', body)
        .then((json) => Rescue.fromJson(json));
  }

  @override
  Future<List<Rescue>> search(int from, int limit) {
    final params = {'offset': from, 'limit': limit};
    return client
        .get<Map<String, dynamic>>('/rescue-service/rescue-posts', params: params)
        .then((value) => (value as List) ?? [])
        .then((value) => value.map((json) => Rescue.fromJson(json)).toList());
  }

  @override
  Future<List<Comment>> getComments(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<RescueDonate>> getDonaters(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<RescueAccount>> getHeroJoined(String id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> join(String id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> like(String id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> unJoin(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Rescue> update(Rescue rescue) {
    throw UnimplementedError();
  }
}
