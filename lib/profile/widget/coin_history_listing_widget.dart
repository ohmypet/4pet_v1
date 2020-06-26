part of petisland.profile.widget;

class CoinHistoryListingWidget extends StatefulWidget {
  final CoinHistoryBloc bloc;

  const CoinHistoryListingWidget({Key key, @required this.bloc}) : super(key: key);
  @override
  _CoinHistoryListingWidgetState createState() => _CoinHistoryListingWidgetState();
}

class _CoinHistoryListingWidgetState extends State<CoinHistoryListingWidget> {
  CoinHistoryBloc get bloc => widget.bloc;
  List<CoinHistory> get coinHistories => bloc.coinHistories;

  final RefreshController controller = RefreshController();

  void initState() {
    super.initState();
    bloc.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoinHistoryBloc, CoinHistoryState>(
      bloc: bloc,
      listener: _onListChanged,
      listenWhen: (_, state) => state is ReloadCoinHisotryListing,
      buildWhen: (_, state) => state is ReloadCoinHisotryListing,
      builder: _buildUIState,
    );
  }

  Widget _buildUIState(BuildContext context, CoinHistoryState state) {
    if (state is ReloadCoinHisotryListing) {
      final divider = const Divider();
      return SmartRefresher(
        controller: controller,
        enablePullDown: true,
        enablePullUp: state.canLoadMore,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(15),
          itemCount: coinHistories.length,
          itemBuilder: (_, index) {
            final coinHistory = coinHistories[index];
            return CoinHistoryWidget(coinHistory: coinHistory);
          },
          separatorBuilder: (_, int index) => divider,
        ),
      );
    } else
      return const SizedBox();
  }

  void _onRefresh() {
    bloc.refresh();
  }

  void _onLoading() {
    bloc.loadMore();
  }

  void _onListChanged(BuildContext context, CoinHistoryState state) {
    if (controller.isLoading) {
      controller.loadComplete();
    }
    if (controller.isRefresh) {
      controller.refreshCompleted();
    }
  }
}
