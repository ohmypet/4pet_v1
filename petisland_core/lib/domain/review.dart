part of petisland_core.domain;

class Review with BaseModel {
  String message;
  List<Image> images;
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
  }) {
    this.id = id;
    this.createAt = createAt;
    this.createBy = createBy;
    this.updateAt = updateAt;
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
