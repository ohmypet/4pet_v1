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
  }
}
