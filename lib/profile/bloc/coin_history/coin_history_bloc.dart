part of petisland.profile.bloc.coin_history;

class CoinHistoryBloc extends TBloc<CoinHistoryEvent, CoinHistoryState> {
  final coinHistories = <CoinHistory>[];
  @override
  Stream<CoinHistoryState> errorToState(BaseErrorEvent event) async* {}

  @override
  Stream<CoinHistoryState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case LoadCoinHistory:
        final loadCoinHistoryEvent = event as LoadCoinHistory;
        yield* _loadCoinHistory(
          from: loadCoinHistoryEvent.from,
          limit: loadCoinHistoryEvent.limit,
          clearOldData: loadCoinHistoryEvent.clearOldData,
        );
        break;
      default:
    }
  }

  @override
  CoinHistoryState get initialState => ReloadCoinHisotryListing(true);

  Stream<CoinHistoryState> _loadCoinHistory(
      {int from, int limit, bool clearOldData}) async* {
    final accountService =
        DI.get<AccountService>(DevModuleCore.account_service_authenticated);
    final coinHistories = await accountService.getCoinHistory(from, limit);
    if (coinHistories.isNotEmpty) {
      if (clearOldData == true) this.coinHistories.clear();
      this.coinHistories.addAll(coinHistories);
      yield ReloadCoinHisotryListing(true);
    } else
      yield ReloadCoinHisotryListing(false);
  }

  void loadMore() {
    add(LoadCoinHistory(from: coinHistories.length));
  }

  void refresh() {
    add(LoadCoinHistory(from: 0, clearOldData: true));
  }
}
