part of petisland.profile.bloc.my_post;

abstract class MyPostEvent extends BaseEvent {}

class _ReloadMyPostEvent extends MyPostEvent {
  final int offset;
  final int limit;

  _ReloadMyPostEvent(this.offset, this.limit);
}

class _ReloadUIEvent extends MyPostEvent {
  final List<PanelDetail> items;

  _ReloadUIEvent(this.items);
}

class _RetrieveMyPostEvent extends MyPostEvent {
  final int offset;
  final int limit;

  _RetrieveMyPostEvent(this.offset, this.limit);
}
