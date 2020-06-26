part of petisland.module;

class DevModule extends AbstractModule {
  // static const String
  @override
  void init() async {
    bind(TWorker).to(TWorker());
    bind(AuthenticationBloc).to(AuthenticationBloc());
    bind(LoginBloc).to(LoginBloc());
    bind(RegisterBloc).to(RegisterBloc());
    bind(PetFeedController).to(PetFeedControllerImpl(get(TWorker)));
    bind(BottomBarController).to(BottomBarControllerImpl());
    bind(Random).to(Random(DateTime.now().millisecondsSinceEpoch));
    bind(NavigationBarBloc).to(NavigationBarBloc());
    bind(ChatBloc).to(ChatBloc());
    bind(NotificationBloc).to(NotificationBloc());
    bind(MyPostBloc).to(MyPostBloc());
    bind(FavoritePostBloc).to(FavoritePostBloc());
    bind(RescueListingBloc).to(RescueListingBloc());
    bind(CoinHistoryBloc).to(CoinHistoryBloc());
  }
}
