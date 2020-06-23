part of petisland_core.domain;

class RescueComment extends BaseModel {
  Comment comment;
  RescueComment({
    String id,
    DateTime createAt,
    DateTime updateAt,
    Account createBy,
    this.comment,
  }) : super(id, createAt, updateAt, createBy);

  RescueComment.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['comment'] != null) {
      comment = Comment.fromJson(json['hero']);
    }
  }
}
