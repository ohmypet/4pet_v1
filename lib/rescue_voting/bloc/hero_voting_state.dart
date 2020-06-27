part of petisland.rescue_voting.bloc;

class HeroVotingState extends BaseState {}

class ReloadHeroVotingListing extends HeroVotingState {
  final bool canLoadMore;

  ReloadHeroVotingListing(this.canLoadMore);
}
