part of petisland.profile.bloc.coin_history;

abstract class CoinHistoryEvent extends BaseEvent {}

class LoadCoinHistory extends CoinHistoryEvent {
  final int from;
  final int limit;
  final bool clearOldData;

  LoadCoinHistory({this.clearOldData = false, this.from = 0, this.limit = 10});
}
