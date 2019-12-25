part of petisland.module;

class DevModule extends AbstractModule {
  // static const String
  @override
  void init() async {
    bind(AuthenticationBloc).to(AuthenticationBloc());
    bind(LoginBloc).to(LoginBloc());
    bind(RegisterBloc).to(RegisterBloc());
    bind(TWorker).to(TWorker());
    bind(PetFeedController).to(PetFeedControllerImpl());
    bind(BottomBarController).to(BottomBarControllerImpl());
    bind(Random).to(Random(DateTime.now().millisecondsSinceEpoch));
  }
}
