part of petisland.petfeed.bloc;

class RescueListingBloc extends TBloc<RescueListingEvent, RescueListingState> {
  final List<Rescue> rescues = [];

  @override
  Stream<RescueListingState> errorToState(BaseErrorEvent event) {
    return null;
  }

  @override
  Stream<RescueListingState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case LoadMoreRescueEvent:
        yield* _handleLoadMore(event);
        break;
      case RefreshResuceListingEvent:
        yield* _handleLoadMore(event, clearOldData: true);
        break;

      default:
    }
  }

  @override
  RescueListingState get initialState => LoadingRescueState();

  Stream<RescueListingState> _handleLoadMore(
    LoadMoreRescueEvent event, {
    bool clearOldData = false,
  }) async* {
    assert(clearOldData != null, 'clearOldData must not null');
    await Future.delayed(const Duration(seconds: 2));
    final rescueService = DI.get<RescueService>(RescueService);
    final newRescuePosts =
        await rescueService.search(from: event.from, limit: event.limit);
    if (newRescuePosts.isEmpty) {
      yield ReloadRescueListingState(false);
    } else {
      if (clearOldData) rescues.clear();
      rescues.addAll(newRescuePosts);
      yield ReloadRescueListingState(true);
    }
  }

  void loadMoreRescuePost() {
    add(LoadMoreRescueEvent(from: rescues.length, limit: 10));
  }

  void refreshRescuePost() {
    add(RefreshResuceListingEvent(from: 0, limit: 20));
  }
}
