part of petisland.rescue_post.bloc;

class RescueCommentBloc extends CommentBloc {
  RescueCommentBloc(String id) : super(id);

  @override
  void loadComment(LoadCommentEvent event) {
    final RescueService service = DI.get(RescueService);
    service.getComments(event.postId).then((items) {
      if (items != null) {
        if (items.isNotEmpty) {
          comments
            ..clear()
            ..addAll(items);
        }
        add(ReloadCommentUIEvent(comments));
      }
    }).catchError(handleOnError);
  }
}
