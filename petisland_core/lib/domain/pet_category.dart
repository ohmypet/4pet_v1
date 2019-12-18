part of petisland_core.domain;

class PetCategory extends BaseModel implements PostItem {
  String name;
  String description;
  PetImage image;

  PetCategory({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.name,
    this.description,
  }) : super(id, createAt, updateAt, createBy);

  PetCategory.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    name = json['name'];
    description = json['description'];
    image = json['image'] != null ? PetImage.fromJson(json['image']) : null;
  }
}
