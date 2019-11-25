part of petisland_core.domain;

class Review extends BaseModel {
  String message;
  List<PetImage> images;
  int stars;
  int likes;

  Review({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.message,
    this.images,
    this.likes,
    this.stars,
  }) : super(id, createAt, updateAt, createBy);

  Review.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    message = json['message'];
    likes = json['likes'];
    stars = json['stars'];
    images = parseImages(json['images']);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = super.toJson();
    _addValueToMap('message', message, map);
    _addValueToMap('stars', stars, map);
    _addValueToMap('likes', likes, map);
    final List<Map<String, dynamic>> json = _imagesToJson(images);
    _addValueToMap('images', json, map);
    return map;
  }
}
