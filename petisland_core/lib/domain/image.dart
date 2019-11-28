part of petisland_core.domain;

class PetImage extends BaseModel {
  String url;
  String publicId;

  PetImage({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.url,
    this.publicId,
  }) : super(id, createAt, updateAt, createBy);

  PetImage.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    url = json['url'];
    publicId = json['public_id'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = super.toJson()..clear();
    _addValueToMap('id', id, map);
    return map;
  }
}
