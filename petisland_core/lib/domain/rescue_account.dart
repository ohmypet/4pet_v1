part of petisland_core.domain;

class RescueAccount extends BaseModel {
  Account hero;
  String status;

  RescueAccount({
    String id,
    DateTime createAt,
    DateTime updateAt,
    Account createBy,
    this.hero,
    this.status,
  }) : super(id, createAt, updateAt, createBy);

  RescueAccount.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['account'] != null) {
      hero = Account.fromJson(json['account']);
    }
    status = json['status'];
  }
}
