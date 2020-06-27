part of petisland.rescue_voting.bloc;

class HeroVotingBloc extends TBloc<HeroVotingEvent, HeroVotingState> {
  

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

  @override
  HeroVotingState get initialState => ReloadHeroVotingListing(true);

  Stream<HeroVotingState> _handleLoadHeroVoting(LoadHeroVoting event) {}

  Stream<HeroVotingState> _handleVoteHero(VoteHeroEvent event) {}
}
