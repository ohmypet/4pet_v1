part of petisland_core.domain;

class PostTag extends BaseModel {
  Tag tag;
  PostTag({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.tag,
  }) : super(id, createAt, updateAt, createBy);

  PostTag.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    tag = json['tag'] != null ? Tag.fromJson(json['tag']) : null;
  }
}
