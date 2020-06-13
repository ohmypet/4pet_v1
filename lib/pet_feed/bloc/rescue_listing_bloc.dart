part of petisland.petfeed.bloc;

class RescueListingBloc extends TBloc<RescueListingEvent, RescueListingState> {
  final List<Rescue> rescue = [];

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
  RescueListingState get initialState => ReloadListingState();

  Stream<RescueListingState> _handleLoadMore(
    LoadMoreRescueEvent event, {
    bool clearOldData = false,
  }) async* {
    assert(clearOldData != null, 'clearOldData must not null');
  }
}
