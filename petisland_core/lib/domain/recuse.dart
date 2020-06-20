part of petisland_core.domain;

class Rescue extends BaseModel {
  String title;
  String description;
  String location;
  String status;
  double totalCoin;
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

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    _addValueToMap('title', title, map);
    _addValueToMap('description', description, map);
    _addValueToMap('location', location, map);
    _addValueToMap('status', status, map);
    _addValueToMap('total_coin', totalCoin, map);
    _addValueToMap('max_heroes', maxHeroes, map);
    _addValueToMap('account', account?.toJson(), map);
    return map;
  }

  Rescue.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    title = json['title'];
    description = json['description'];
    location = json['location'];
    status = json['status'];
    totalCoin = json['total_coin'] ?? 0;
    maxHeroes = json['max_heroes'] ?? 0;
    if (json['account'] != null) {
      account = Account.fromJson(json['account']);
    }
    isReacted = json['is_liked'] ?? false;
    currentHeroes = json['current_heroes'] ?? 0;
  }

  Rescue.empty() : super(ThinId.randomId(), null, null, null) {
    title = '';
    description = '';
    status = '';
    totalCoin = 0;
    maxHeroes = 3;
    account = null;
    rescueImages = [];
  }

  bool get titleIsValid => title != null && title.isNotEmpty;

  bool get locatonIsValid => location != null && location.isNotEmpty;

  String get firstImage {
    final RescueImage item = rescueImages
        .firstWhere((rescueImage) => rescueImage.image?.url != null, orElse: () => null);
    if (item != null) {
      return item.image.url;
    } else {
      return null;
    }
  }

  String get avatar => account?.user?.avatar?.url;

  String get likeAsString => likes?.toString() ?? '0';

  String get maxHeroeAsString {
    if (maxHeroes != null && maxHeroes > 0) {
      return '$currentHeroesAsString/${maxHeroes.toString()}';
    } else {
      return '$currentHeroesAsString/∞';
    }
  }

  String get currentHeroesAsString => currentHeroes?.toString() ?? '0';

  bool get canJoin {
    if (maxHeroes != null && maxHeroes > 0) {
      return currentHeroes < maxHeroes;
    } else
      return true;
  }

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

  int unLike() {
    final likes = getLikes();
    if (isReacted == false) {
      return likes;
    } else {
      isReacted = false;
      return this.likes = likes > 0 ? likes - 1 : 0;
    }
  }
}
