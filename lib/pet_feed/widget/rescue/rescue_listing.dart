part of petisland.pet_feed.widget.rescue;

class RescueListing extends TStatefulWidget {
  final VoidCallback onTapCreateRescuePost;
  final RescueListingBloc listingBloc;

  const RescueListing({
    Key key,
    @required this.listingBloc,
    this.onTapCreateRescuePost,
  }) : super(key: key);

  @override
  TState<RescueListing> createState() => _RescueListingState();
}

class _RescueListingState extends TState<RescueListing> {
  static const defaultLoading = const PreviewRescueDefaultWidget();
  static const box = SizedBox(width: 10);
  final refreshController = RefreshController();

  RescueListingBloc get bloc => widget.listingBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: PanelDescriptionBar(
              title: 'Need help',
              onTapSubTitle: _onTapSeeMore,
              showSubtitle: false,
            ),
          ),
          const SizedBox(height: 5),
          Flexible(child: _buildRescuePostSlider()),
        ],
      ),
    );
  }

  void initState() {
    super.initState();
    if (bloc.rescues.isEmpty) {
      bloc.loadMoreRescuePost();
    }
  }

  Widget _buildButtonAdd() {
    return AspectRatio(
      aspectRatio: TConstants.ratio4y3, //4.3
      child: AddableWidget(
        onPress: widget.onTapCreateRescuePost,
      ),
    );
  }

  Widget _buildRescueListing(ReloadRescueListingState state) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      scrollDirection: Axis.horizontal,
      enablePullUp: state.canLoadMore,
      header: ClassicHeader(
        iconPos: IconPosition.top,
        outerBuilder: (child) {
          return Container(
            width: 160.0,
            child: Center(
              child: child,
            ),
          );
        },
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.separated(
        itemCount: bloc.rescues.length + 1,
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        itemBuilder: (_, index) {
          if (index == 0)
            return _buildButtonAdd();
          else {
            return PreviewRescuePostWidget(
              rescue: bloc.rescues[index - 1],
              onTapRescuePost: _handleOnTapRescuePost,
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) => box,
      ),
    );
  }

  Widget _buildRescueLoading() {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: false,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      itemBuilder: (_, __) => defaultLoading,
      separatorBuilder: (_, __) => box,
    );
  }

  Widget _buildRescuePostSlider() {
    return BlocConsumer<RescueListingBloc, RescueListingState>(
      bloc: bloc,
      listenWhen: (_, state) => state is ReloadRescueListingState,
      listener: _handleOnStateChange,
      buildWhen: (_, state) => state is ReloadRescueListingState,
      builder: (BuildContext context, state) {
        switch (state.runtimeType) {
          case ReloadRescueListingState:
            return _buildRescueListing(state);
            break;
          default:
            return _buildRescueLoading();
        }
      },
    );
  }

  void _handleDeleteRescue(Rescue rescue) {
    // TODO(tvc12): Handle delete rescue
  }

  void _handleOnStateChange(BuildContext context, RescueListingState state) {
    if (refreshController.isLoading) {
      refreshController.loadComplete();
    }
    if (refreshController.isRefresh) {
      refreshController.refreshCompleted();
    }
  }

  void _handleOnTapRescuePost(Rescue rescue) {
    navigateToScreen(
      context: context,
      screen: RescueDetailScreen(
        rescue: rescue,
        onDeleteRescue: _handleDeleteRescue,
      ),
      screenName: RescueDetailScreen.name,
    ).whenComplete(() {
      setState(() {});
    });
  }

  void _onLoading() {
    bloc.loadMoreRescuePost();
  }

  void _onRefresh() {
    bloc.refreshRescuePost();
  }

  void _onTapSeeMore() {}
}
