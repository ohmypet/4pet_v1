part of petisland.profile.bloc.favorite_post;

abstract class FavoritePostEvent extends BaseEvent {}

class _ReloadFavoritePostEvent extends FavoritePostEvent {
  final int offset;
  final int limit;

  _ReloadFavoritePostEvent(this.offset, this.limit);
}

class _ReloadUIEvent extends FavoritePostEvent {
  final List<PanelDetail> items;

  _ReloadUIEvent(this.items);
}

class _RetrieveFavoritePostEvent extends FavoritePostEvent {
  final int offset;
  final int limit;

  _RetrieveFavoritePostEvent(this.offset, this.limit);
}
