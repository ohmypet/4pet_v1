part of petisland.post.post_detail.bloc;

abstract class CommentEvent extends BaseEvent {}

class LoadCommentEvent extends CommentEvent {
  final String postId;

  LoadCommentEvent(this.postId);
}

class ReloadCommentUIEvent extends CommentEvent {
  final List<Comment> items;

  ReloadCommentUIEvent(this.items);
}

class SoftReloadEvent extends CommentEvent {
  final Comment item;

  SoftReloadEvent(this.item);
}
