part of petisland.rescue_post.bloc;

abstract class RescueHeroState extends BaseState {}

class ReloadListingState extends RescueHeroState {
  final bool canLoadMore;

  ReloadListingState(this.canLoadMore);
}
