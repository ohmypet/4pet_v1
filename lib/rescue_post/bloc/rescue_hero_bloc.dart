part of petisland.rescue_post.bloc;

class RescueHeroBloc extends TBloc<RescueHeroEvent, RescueHeroState> {
  final String id;

  final List<RescueAccount> rescueAccounts = [];

  RescueHeroBloc(this.id);

  @override
  Stream<RescueHeroState> errorToState(BaseErrorEvent event) async* {}

  @override
  Stream<RescueHeroState> eventToState(BaseEvent event) async* {}

  @override
  RescueHeroState get initialState => ReloadListingHeroState();
}
