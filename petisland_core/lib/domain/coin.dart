part of petisland_core.domain;

class Coin extends BaseModel {
  int coins;
  List<CoinHistory> coinHistories;

  Coin({
    String id,
    DateTime createAt,
    DateTime updateAt,
    Account createBy,
    this.coins = 0,
    this.coinHistories = const [],
  }) : super(id, createAt, updateAt, createBy);

  Coin.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['coins'] != null) {
      coins = int.tryParse(json['coins'].toString()) ?? 0;
    } else
      coins = 0;

    if (json['coinHistories'] != null) {
      coinHistories = (json['coinHistories'] as List)
          .map((json) => CoinHistory.fromJson(json))
          .toList();
    } else
      coinHistories = [];
  }

  Coin.empty() : super(ThinId.randomId(), DateTime.now(), DateTime.now(), null) {
    this.coins = 0;
    coinHistories = [];
  }
}
