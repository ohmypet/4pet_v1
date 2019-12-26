part of petisland.profile.bloc.favorite_post;

abstract class FavoritePostState extends BaseState {}

class ReloadFavoritePost extends FavoritePostState {
  final List<PanelDetail> items;

  ReloadFavoritePost(this.items);

  @override
  String toString() => '$runtimeType-${items.length}';
}

class IniFavoritePostState extends FavoritePostState {}
