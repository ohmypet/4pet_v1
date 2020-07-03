part of petisland.rescue_post.bloc;

class RescueHeroBloc extends TBloc<RescueHeroEvent, RescueHeroState> {
  final String id;

  final List<RescueAccount> rescueAccounts = [];

  List<Account> get heroes => rescueAccounts.map((e) => e.hero).toList();

  RescueService get service => DI.get(RescueService);

  RescueHeroBloc(this.id);

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

  @override
  RescueHeroState get initialState => ReloadListingState(heroes.isNotEmpty);

  Stream<RescueHeroState> _handleLoadHeroEvent(LoadHeroEvent event) async* {
    final heroes = await service.getHeroJoined(id);
    if (event.clearOldData == true) {
      this.rescueAccounts.clear();
    }
    this.rescueAccounts.addAll(heroes);
    yield ReloadListingState(heroes.isNotEmpty);
  }

  void reload() {
    add(LoadHeroEvent(clearOldData: true));
  }

  void loadMore() {
    add(LoadHeroEvent(offset: rescueAccounts.length, limit: 10));
  }
}
