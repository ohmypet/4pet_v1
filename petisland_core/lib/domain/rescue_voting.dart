part of petisland_core.domain;

class RescueVoting extends BaseModel {
  RescueAccount voter;
  RescueAccount hero;

  RescueVoting({
    String id,
    DateTime createAt,
    DateTime updateAt,
    Account createBy,
    this.voter,
    this.hero,
  }) : super(id, createAt, updateAt, createBy);

  RescueVoting.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['voter'] != null) {
      voter = RescueAccount.fromJson(json['voter']);
    }
    if (json['hero'] != null) {
      hero = RescueAccount.fromJson(json['hero']);
    }
  }
}
