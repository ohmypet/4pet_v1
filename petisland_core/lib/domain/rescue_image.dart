part of petisland_core.domain;

class RescueImage extends BaseModel {
  PetImage image;

  RescueImage({
    String id,
    DateTime createAt,
    DateTime updateAt,
    Account createBy,
    this.image,
  }) : super(id, createAt, updateAt, createBy);

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    _addValueToMap('image', image?.toJson(), map);
    return map;
  }

  RescueImage.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['image'] != null) {
      image = PetImage.fromJson(json['image']);
    }
  }
}
