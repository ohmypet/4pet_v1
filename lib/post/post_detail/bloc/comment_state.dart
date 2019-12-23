part of petisland.post.post_detail.bloc;

abstract class CommentState extends BaseState {}

class CommentStateInit extends CommentState {}

class RealoadUIState extends CommentState {
  final List<Comment> items;

  RealoadUIState(this.items);

  @override
  String toString() => 'RealoadUIState:: ${items.length}';
}
