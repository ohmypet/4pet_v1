part of petisland.profile.bloc.my_post;

abstract class MyPostState extends BaseState {}

class ReloadMyPost extends MyPostState {
  final List<PanelDetail> items;

  ReloadMyPost(this.items);

  @override
  String toString() => '$runtimeType-${items.length}';
}

class InitMyPostState extends MyPostState {}
