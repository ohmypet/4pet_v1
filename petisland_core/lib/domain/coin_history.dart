part of petisland_core.domain;

class CoinHistory extends BaseModel {
  String title;
  String description;
  int change;

  int get coin => change ?? 0;

  CoinHistory(
      {String id,
      DateTime createAt,
      DateTime updateAt,
      Account createBy,
      this.title = '',
      this.description = '',
      this.change = 0})
      : super(id, createAt, updateAt, createBy);

  CoinHistory.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    if (json['change'] != null) {
      change = int.tryParse(json['change'].toString()) ?? 0;
    } else
      change = 0;
  }
}
