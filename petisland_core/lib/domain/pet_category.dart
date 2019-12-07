part of petisland_core.domain;

class PetCategory extends BaseModel implements PostItem {
  String name;
  String description;

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
  }
}
