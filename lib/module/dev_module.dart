part of petisland.module;

class DevModule extends AbstractModule {
  // static const String
  @override
  void init() async {
    bind(AuthenticationBloc).to(AuthenticationBloc());
  }
}
