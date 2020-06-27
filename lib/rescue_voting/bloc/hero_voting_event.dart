part of petisland.rescue_voting.bloc;

class HeroVotingEvent extends BaseEvent {}

class LoadHeroVoting extends HeroVotingEvent {
  final int from;
  final int limit;
  final bool clearOldData;

  LoadHeroVoting({
    this.from = 0,
    this.limit = 10,
    this.clearOldData = false,
  });
}

class VoteHeroEvent extends HeroVotingEvent {
  final int heroId;

  VoteHeroEvent(this.heroId);
}
