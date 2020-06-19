part of petisland.rescue_post.bloc;

class RescueDonateBloc extends TBloc<RescueHeroEvent, RescueHeroState> {
  final String id;
  final List<RescueDonate> rescueDonates = [];

  RescueDonateBloc(this.id);
  
  RescueService get service => DI.get(RescueService);

  @override
  Stream<RescueHeroState> errorToState(BaseErrorEvent event) async* {}

  @override
  Stream<RescueHeroState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case LoadHeroEvent:
        yield* _handleLoadHeroEvent(event);
        break;
      default:
    }
  }

  Stream<RescueHeroState> _handleLoadHeroEvent(
    LoadHeroEvent event, {
    bool clearOldData,
  }) async* {
    final heroes = await service.getDonaters();
    if (clearOldData == true) {
      this.rescueDonates.clear();
    }
    this.rescueDonates.addAll(heroes);
    yield ReloadListingState(heroes.isNotEmpty);
  }

  void reload() {
    add(LoadHeroEvent());
  }

  void loadMore() {
    add(LoadHeroEvent(offset: rescueDonates.length, limit: 10));
  }

  @override
  RescueHeroState get initialState => ReloadListingState(true);
}
