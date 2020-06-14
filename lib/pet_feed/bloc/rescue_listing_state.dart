part of petisland.petfeed.bloc;

abstract class RescueListingState extends BaseState {}

class ReloadRescueListingState extends RescueListingState {
  final bool canLoadMore;
  ReloadRescueListingState([this.canLoadMore = true]);
}

class LoadingRescueState extends ReloadRescueListingState {}
