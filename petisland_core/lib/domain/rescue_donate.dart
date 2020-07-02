part of petisland_core.domain;

class RescueDonate extends BaseModel {
  Account account;
  int coin;
  RescueDonate({
    String id,
    DateTime createAt,
    DateTime updateAt,
    Account createBy,
    this.account,
    this.coin,
  }) : super(id, createAt, updateAt, createBy);

  RescueDonate.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['account'] != null) {
      account = Account.fromJson(json['account']);
    }
    coin = int.parse(json['coin'].toString()) ?? 0;
  }
}
