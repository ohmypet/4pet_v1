part of petisland_core.domain;

class PostImage extends BaseModel {
  PetImage image;
  PostImage({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.image,
  }) : super(id, createAt, updateAt, createBy);

  PostImage.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    image = json["image"] != null ? PetImage.fromJson(json["image"]) : null;
  }
}
