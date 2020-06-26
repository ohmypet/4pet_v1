part of petisland_core.domain;

class Coin extends BaseModel {
  int coin;
  List<CoinHistory> coinHistories;

  Coin({
    String id,
    DateTime createAt,
    DateTime updateAt,
    Account createBy,
    this.coin = 0,
    this.coinHistories = const [],
  }) : super(id, createAt, updateAt, createBy);

  Coin.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['coin'] != null) {
      coin = int.tryParse(json['coin'].toString()) ?? 0;
    } else
      coin = 0;

    if (json['coinHistories'] != null) {
      coinHistories = (json['coinHistories'] as List)
          .map((json) => CoinHistory.fromJson(json))
          .toList();
    } else
      coinHistories = [];
  }

  Coin.empty() : super(ThinId.randomId(), DateTime.now(), DateTime.now(), null) {
    this.coin = 0;
    coinHistories = [];
  }
}
