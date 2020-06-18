part of petisland.rescue_post.bloc;

abstract class RescueHeroState extends BaseState {}

class ReloadListingHeroState extends RescueHeroState {
  final bool canLoadMore;

  ReloadListingHeroState(this.canLoadMore);
}
