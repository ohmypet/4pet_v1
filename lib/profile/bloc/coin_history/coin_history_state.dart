part of petisland.profile.bloc.coin_history;

abstract class CoinHistoryState extends BaseState {}

class ReloadCoinHisotryListing extends CoinHistoryState {
  final bool canLoadMore;

  ReloadCoinHisotryListing(this.canLoadMore);
}
