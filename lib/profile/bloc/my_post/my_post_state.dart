part of petisland.profile.bloc.my_post;

abstract class MyPostState extends BaseState {}

class ReloadUI extends MyPostState {
  final List<PanelDetail> items;

  ReloadUI(this.items);

  @override
  String toString() => '$runtimeType-${items.length}';
}

class InitMyPostState extends MyPostState {}
