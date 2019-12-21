part of petisland_core.domain;

class PostEditModal {
  final String id;
  String title;
  String description;
  String location;
  Map<String, dynamic> settings;
  String status;
  double price;
  Pet pet;
  final List<Tag> newTags = [];
  final List<String> postIdTagsDelete = [];

  final List<String> newsImages = [];
  final List<String> deleteImages = [];

  PostEditModal(
    this.id, {
    this.title,
    this.description,
    this.location,
    this.settings = const {},
    this.status,
    this.price,
    this.pet,
    List<Tag> newTags = const [],
    List<String> postIdTagsDelete = const [],
    List<String> idImages = const [],
    List<String> idImagesDelete = const [],
  }) {
    this.newTags.addAll([...?newTags]);
    this.postIdTagsDelete.addAll([...?postIdTagsDelete]);
    this.newsImages.addAll([...?idImages]);
    this.deleteImages.addAll([...?idImagesDelete]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    _addValueToMap('title', title, map);
    _addValueToMap('description', description, map);
    _addValueToMap('location', location, map);
    _addValueToMap('settings', settings, map);
    _addValueToMap('status', status, map);
    _addValueToMap('price', price, map);
    _addValueToMap('pet', pet.toCreateJson(), map);
    final Map<String, dynamic> images = {};
    _addValueToMap('newImages', newsImages, images);
    _addValueToMap('deleteImages', deleteImages, images);
    _addValueToMap('images', images, map);
    return map;
  }
}
