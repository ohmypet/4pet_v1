part of petisland_core.repository;

abstract class RescueRepository {
  Future<List<Rescue>> search();

  Future<Rescue> create(Rescue rescue);
  Future<Rescue> update(Rescue rescue);

  Future<bool> join(String id);
  Future<bool> unJoin(String id);

  Future<bool> like(String id);

  Future<List<RescueAccount>> getHeroJoined();
  Future<List<RescueDonate>> getDonaters();
}

class MockRescueRepository extends RescueRepository {
  @override
  Future<Rescue> create(Rescue rescue) {
    return Future.value(rescue);
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

  final titles = <String>[
    'Cần sự trợ giúp để cứu một chú mèo đang gặp nạn',
    'Giúp mình cứu một con chó đang ngủ',
    'Cần tìm người chữa bệnh cho chó của mình',
    'Cần tìm người để giải cứu mèo đang bị kẹt ở trên cao',
  ];
  String get title => titles[ran.nextInt(titles.length - 1)];

  List<RescueImage> get rescueImages {
    final size = ran.nextInt(10);
    return List.generate(
      size,
      (_) => RescueImage(id: ThinId.randomId(), image: avatar),
    );
  }

  Account get account => Account(
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
  User get user => User(
        id: ThinId.randomId(),
        name: ThinId.randomId(numberCharacter: 5),
        phoneNumber: '0966144938',
        avatar: avatar,
      );

  PetImage get avatar => PetImage(id: ThinId.randomId(), url: image);

  final images = [
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
  final ran = Random();

  String get image {
    return images[ran.nextInt(images.length - 1)];
  }

  List<String> get listImage {
    final size = ran.nextInt(images.length - 1);
    return images.toList().sublist(0, size)..shuffle();
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
  Future<List<Rescue>> search() async {
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
  Future<List<RescueDonate>> getDonaters() {
    return Future.value(
      List.generate(
        ran.nextInt(10),
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
  Future<List<RescueAccount>> getHeroJoined() {
    return Future.value(
      List.generate(
        10,
        (index) => RescueAccount(
          id: ThinId.randomId(),
          hero: account,
          status: ThinId.randomId(numberCharacter: 5),
          createAt: DateTime.now(),
        ),
      ),
    );
  }
}
