part of petisland_core.domain;

class HeroVotingInfo extends BaseModel {
  Account hero;
  int vote;
  bool isVoted;

  String get voteAsString => '${vote ?? 0}';
  HeroVotingInfo(
      {String id,
      DateTime createAt,
      DateTime updateAt,
      Account createBy,
      this.hero,
      this.vote = 0,
      this.isVoted = false})
      : super(id, createAt, updateAt, createBy);

  HeroVotingInfo.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['hero'] != null) hero = Account.fromJson(json['hero']);
    vote = json['vote'] ?? 0;
    isVoted = json['isVoted'] ?? false;
  }
}
