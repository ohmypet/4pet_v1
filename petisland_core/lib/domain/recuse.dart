part of petisland_core.domain;

class Rescue extends BaseModel {
  String title;
  String description;
  String location;
  int status;
  int totalCoin;
  int maxHeroes;
  int currentHeroes;
  int likes;
  Account account;
  bool isJoined;
  bool isReacted;
  List<RescueImage> rescueImages;

  Rescue({
    String id,
    DateTime createAt,
    DateTime updateAt,
    Account createBy,
    this.title,
    this.description,
    this.location,
    this.status,
    this.totalCoin,
    this.maxHeroes = 0,
    this.currentHeroes = 0,
    this.likes = 0,
    this.account,
    this.isJoined = true,
    this.rescueImages = const [],
    this.isReacted = false,
  }) : super(id, createAt, updateAt, createBy);

  Rescue.empty() : super(ThinId.randomId(), null, null, null) {
    title = '';
    description = '';
    status = RescueStatus.Open.index;
    totalCoin = 0;
    maxHeroes = 3;
    account = null;
    rescueImages = [];
  }

  Rescue.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    title = json['title'];
    description = json['description'];
    location = json['location'];
    status = json['status'];
    totalCoin = json['totalCoin'] ?? 0;
    maxHeroes = json['maxHeroes'] ?? 0;
    if (json['account'] != null) {
      account = Account.fromJson(json['account']);
    }
    isReacted = json['isReacted'] ?? false;
    currentHeroes = json['currentHeroes'] ?? 0;
    likes = json['likes'] ?? 0;
    isJoined = json['isJoined'] ?? false;
  }

  String get avatar => account?.user?.avatar?.url;

  bool get canJoin {
    if (maxHeroes != null && maxHeroes > 0) {
      return currentHeroes < maxHeroes;
    } else
      return true;
  }

  String get currentHeroesAsString => currentHeroes?.toString() ?? '0';

  String get firstImage {
    final RescueImage item = rescueImages
        ?.firstWhere((rescueImage) => rescueImage.image?.url != null, orElse: () => null);
    if (item != null) {
      return item.image.url;
    } else {
      return null;
    }
  }

  String get likeAsString => likes?.toString() ?? '0';

  bool get locatonIsValid => location != null && location.isNotEmpty;

  String get maxHeroeAsString {
    if (maxHeroes != null && maxHeroes > 0) {
      return '$currentHeroesAsString/${maxHeroes.toString()}';
    } else {
      return '$currentHeroesAsString/∞';
    }
  }

  bool get titleIsValid => title != null && title.isNotEmpty;

  int getLikes() {
    if (likes != null && likes > 0)
      return likes;
    else
      return 0;
  }

  int like() {
    final likes = getLikes();
    if (isReacted == true) {
      return likes;
    } else {
      isReacted = true;
      return this.likes = likes + 1;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    _addValueToMap('title', title, map);
    _addValueToMap('description', description, map);
    _addValueToMap('location', location, map);
    _addValueToMap('totalCoins', totalCoin, map);
    _addValueToMap('maxHeroes', maxHeroes, map);
    _addValueToMap('account', account?.toJson(), map);
    return map;
  }

  int unLike() {
    final likes = getLikes();
    if (isReacted == false) {
      return likes;
    } else {
      isReacted = false;
      return this.likes = likes > 0 ? likes - 1 : 0;
    }
  }

  Rescue clone() {
    return Rescue(
      id: this.id,
      account: this.account,
      createAt: this.createAt,
      createBy: this.createBy,
      currentHeroes: this.currentHeroes,
      description: this.description,
      isJoined: this.isJoined,
      isReacted: this.isReacted,
      likes: this.likes,
      location: this.location,
      maxHeroes: this.maxHeroes,
      rescueImages: this.rescueImages,
      status: this.status,
      title: this.title,
      totalCoin: this.totalCoin,
      updateAt: this.updateAt,
    );
  }
}
