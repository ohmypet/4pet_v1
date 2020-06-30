part of petisland.rescue_voting.bloc;

class HeroVotingBloc extends TBloc<HeroVotingEvent, HeroVotingState> {
  final String rescueId;
  final heroes = <HeroVotingInfo>[];

  HeroVotingBloc(this.rescueId);

  @override
  HeroVotingState get initialState => ReloadHeroVotingListing(true);
  RescueVotingService get votingService => DI.get(RescueVotingService);

  @override
  Stream<HeroVotingState> errorToState(BaseErrorEvent event) async* {}

  @override
  Stream<HeroVotingState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case LoadHeroVoting:
        yield* _handleLoadHeroVoting(event);
        break;
      case VoteHeroEvent:
        yield* _handleVoteHero(event);
        break;
      default:
    }
  }

  Stream<HeroVotingState> _handleLoadHeroVoting(LoadHeroVoting event) async* {
    final heroes = await votingService.getHeroVotings();
    if (heroes?.isNotEmpty == true) {
      if (event.clearOldData == true) {
        this.heroes.clear();
      }
      this.heroes.addAll(heroes);
      yield ReloadHeroVotingListing(true);
    } else {
      yield ReloadHeroVotingListing(false);
    }
  }

  Stream<HeroVotingState> _handleVoteHero(VoteHeroEvent event) async* {
    final heroVotingInfo = await votingService.vote(rescueId, event.heroId);
    final itemNeedUpdate = heroes.firstWhere(
      (element) => element.hero.id == heroVotingInfo.hero.id,
      orElse: () => null,
    );
    if (itemNeedUpdate != null) {
      itemNeedUpdate
        ..hero = heroVotingInfo.hero
        ..isVoted = heroVotingInfo.isVoted
        ..vote = heroVotingInfo.vote;
    }
    yield ReloadHeroVotingListing(true);
  }

  void loadHeroes() {
    add(LoadHeroVoting(clearOldData: false));
  }

  void vote(String heroId) {
    add(VoteHeroEvent(heroId));
  }
}
