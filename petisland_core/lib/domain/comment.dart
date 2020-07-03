part of petisland_core.domain;

class Comment extends BaseModel {
  String message;
  List<PetImage> images;
  int likes;

  Comment({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.message,
    this.images,
    this.likes,
  }) : super(id, createAt, updateAt, createBy);

  Comment.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    message = json['message'];
    likes = json['likes'];
    images = parseImages(json['images']);
  }

  Comment.fromRescue(Map<String, dynamic> json) : super.fromJson(json) {
    message = json['message'];
    likes = json['likes'];
    images = parseImages(json['images']);
    if (json['account'] != null) {
      createBy = Account.fromJson(json['account']);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = super.toJson();
    _addValueToMap('message', message, map);
    _addValueToMap('likes', likes, map);
    final List<Map<String, dynamic>> json = _imagesToJson(images);
    _addValueToMap('images', json, map);

    return map;
  }
}
