part of petisland_core.domain;

class Report extends BaseModel {
  String reason;
  String description;
  String status;

  Report({
    String id,
    DateTime createAt,
    DateTime updateAt,
    Account createBy,
    this.reason,
    this.description,
    this.status,
  }) : super(id, createAt, updateAt, createBy);

  Report.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    reason = json['reason'];
    description = json['description'];
    status = json['status'];
  }
}
