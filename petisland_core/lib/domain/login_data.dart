part of petisland_core.domain;

class LoginData extends BaseModel {
  String token;
  Account account;

  LoginData({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.token,
    this.account,
  }) : super(id, createAt, updateAt, createBy);

  LoginData.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    token = json['token'];
    account = json['account'] != null ? Account.fromJson(json['account']) : null;
  }
}
