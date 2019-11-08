part of petisland_core.domain;

class Post extends BaseModel {
  String title;
  String description;
  String location;
  double price;
  DateTime dueDate;
  Map<String, dynamic> settings;
  String status;
  Account account;
  Pet pet;
  List<Image> images;
  List<Tag> tags;

  int likes;

  Post({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.title,
    this.description,
    this.location,
    this.price = 0,
    this.dueDate,
    this.settings = const <String, dynamic>{},
    this.status,
    this.account,
    this.pet,
    this.images = const <Image>[],
    this.tags = const <Tag>[],
    this.likes,
  }) : super(id, createAt, updateAt, createBy);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = super.toJson();
    _addValueToMap('title', title, map);
    _addValueToMap('description', description, map);
    _addValueToMap('location', location, map);
    _addValueToMap('price', price, map);
    _addValueToMap('due_date', dueDate?.toIso8601String(), map);
    _addValueToMap('settings', settings, map);
    _addValueToMap('status', status, map);
    _addValueToMap('account', account?.toJson(), map);
    _addValueToMap('pet', pet?.toJson(), map);
    final List<Map<String, dynamic>> json = _imagesToJson(images);
    _addValueToMap('images', json, map);
    _addValueToMap('likes', likes, map);

    return map;
  }
}
