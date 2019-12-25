part of petisland.home_page_widget.bloc;

abstract class NavigationBarEvent extends BaseEvent {}

class NavigationToEvent extends NavigationBarEvent {
  final Tabs tab;

  NavigationToEvent(this.tab);

  @override
  String toString() => '$runtimeType::index $tab';
}

class ShowNavigationBarEvent extends NavigationBarEvent {}

class HideNavigationBarEvent extends NavigationBarEvent {}
