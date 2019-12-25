part of petisland.post.post_detail.bloc;

abstract class CommentState extends BaseState {}

class CommentStateInit extends CommentState {}

class ReloadUIState extends CommentState {
  final List<Comment> items;

  ReloadUIState(this.items);

  @override
  String toString() => 'RealoadUIState:: ${items.length}';
}

class ScrollToBottom extends CommentState {}
