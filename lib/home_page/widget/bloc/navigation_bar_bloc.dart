part of petisland.home_page_widget.bloc;

class NavigationBarBloc extends TBloc<NavigationBarEvent, NavigationBarState> {
  static final BottomBarController controller = DI.get(BottomBarController);

  @override
  Duration get delayEvent => const Duration(milliseconds: 150);

  @override
  Stream<NavigationBarState> errorToState(BaseErrorEvent event) {
    return null;
  }

  @override
  Stream<NavigationBarState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case ShowNavigationBarEvent:
        yield ShowNavigationBar();
        break;
      case HideNavigationBarEvent:
        yield HideNavigationBar();
        break;
      case NavigationToEvent:
        final int index = (event as NavigationToEvent).tab.index;
        controller.navigateTo(index);
        break;
      default:
    }
  }

  @override
  NavigationBarState get initialState => InitNavigationBar();

  void show() {
    add(ShowNavigationBarEvent());
  }

  void hide() {
    add(HideNavigationBarEvent());
  }

  void navigationTo(Tabs tab) {
    add(NavigationToEvent(tab));
  }
}
