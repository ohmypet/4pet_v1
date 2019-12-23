part of petisland.post.post_detail.bloc;

class CommentBloc extends TBloc<CommentEvent, CommentState> {
  static final PostService service = DI.get(PostService);

  final List<Comment> comment = <Comment>[];
  final String postId;

  CommentBloc(this.postId);

  @override
  Duration get delayEvent => const Duration(milliseconds: 150);

  @override
  Stream<CommentState> errorToState(BaseErrorEvent event) {
    return null;
  }

  @override
  Stream<CommentState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case LoadCommentEvent:
        _loadComment(event);
        break;
      case ReloadCommentUIEvent:
        yield* _reloadUI(event);
        break;
      default:
    }
  }

  void _loadComment(LoadCommentEvent event) {
    service.getComments(event.postId).then((items) {
      if (items.isNotEmpty) {
        comment
          ..clear()
          ..addAll(items);
        add(ReloadCommentUIEvent(items));
      }
    }).catchError(_handleError);
  }

  @override
  CommentState get initialState => CommentStateInit();

  FutureOr _handleError(dynamic ex) {
    Log.error(ex);
  }

  Stream<CommentState> _reloadUI(ReloadCommentUIEvent event) async* {
    yield RealoadUIState(event.items);
  }

  void reload() {
    add(LoadCommentEvent(postId));
  }
}
