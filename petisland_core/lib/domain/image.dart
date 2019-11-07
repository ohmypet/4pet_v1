part of petisland_core.domain;

class Image with BaseModel {
  String url;
  String publicId;

  Image({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.url,
    this.publicId,
  }) {
    this.id = id;
    this.createAt = createAt;
    this.createBy = createBy;
    this.updateAt = updateAt;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = super.toJson();
    _addValueToMap('url', url, map);
    _addValueToMap('public_id', publicId, map);
    return map;
  }
}
