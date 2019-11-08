part of petisland_core.domain;

class LoginSession extends BaseModel {
  String token;
  Account account;

  LoginSession({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.token,
    this.account,
  }) : super(id, createAt, updateAt, createBy);

// LoginSession.fromJson(Map<String, dynamic> json) {
//   token = json['token'];
//   // account = json['account'] != null ? Account.(json['account']) : null;
// }
}
