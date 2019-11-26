part of petisland_core.domain;

class PostModal {
  String title;
  String description;
  String location;
  DateTime dueDate = DateTime.now();
  Map<String, dynamic> settings = <String, dynamic>{};
  final String status;
  double price;
  Pet pet;
  List<Tag> tags = <Tag>[];
  final List<PetImage> images = <PetImage>[];

  PostModal.create({
    @required this.title,
    @required this.location,
    @required this.price,
    @required this.pet,
    this.description,
    List<Tag> tags = const <Tag>[],
    List<PetImage> images = const <PetImage>[],
  }) : status = enumToString(PostStatus.New) {
    this.tags.addAll(tags);
    this.images.addAll(images);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    assert(title != null, "title musn't null");
    assert(location != null, "location musn't null");
    assert(pet != null, "pet musn't null");
    assert(price != null, "price musn't null");

    _addValueToMap('title', title, map);
    _addValueToMap('description', description, map);
    _addValueToMap('location', location, map);
    _addValueToMap('dueDate', dueDate.toIso8601String(), map);
    _addValueToMap('settings', settings, map);
    _addValueToMap('status', status, map);
    _addValueToMap('price', price ?? 0, map);

    final List<Map<String, dynamic>> jsonImages = _imagesToJson(images);
    _addValueToMap("images", jsonImages, map);

    final List<Map<String, dynamic>> jsonTags = _tagsToJson(tags);
    _addValueToMap("tags", jsonTags, map);

    _addValueToMap("pet", pet.toCreateJson(), map);

    return map;
  }
}
