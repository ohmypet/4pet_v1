part of petisland.post.post_detail.bloc;

class CommentBloc extends TBloc<CommentEvent, CommentState> {
  static final PostService service = DI.get(PostService);

  final List<Comment> comments = <Comment>[];

  final String postId;

  @protected
  Timer timer;

  CommentBloc(this.postId);

  void startListener() {
    reload();
    if (timer?.isActive == true) timer.cancel();
    timer = Timer.periodic(const Duration(seconds: 5), (_) => reload());
  }

  void stopListener() {
    if (timer?.isActive == true) timer.cancel();
  }

  @override
  Duration get delayEvent => const Duration(milliseconds: 250);

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
      case SoftAddCommentEvent:
        yield* _softAdd(event);
        break;
      case SoftDeleteCommentEvent:
        yield* _softDelete(event);
        break;
      default:
    }
  }

  void _loadComment(LoadCommentEvent event) {
    service.getComments(event.postId).then((items) {
      if (items != null) {
        if (items.isNotEmpty) {
          comments
            ..clear()
            ..addAll(items);
        }
        add(ReloadCommentUIEvent(comments));
      }
    }).catchError(_handleError);
  }

  @override
  CommentState get initialState => CommentStateInit();

  FutureOr _handleError(dynamic ex) {
    Log.error(ex);
  }

  Stream<CommentState> _reloadUI(ReloadCommentUIEvent event) async* {
    yield ReloadUIState(event.items);
  }

  Stream<CommentState> _softAdd(SoftAddCommentEvent event) async* {
    yield ScrollToBottom();
    comments.add(event.item);
    yield ReloadUIState(comments);
  }

  Stream<CommentState> _softDelete(SoftDeleteCommentEvent event) async* {
    final index = event.index;
    if (index > 0 && index < comments.length) {
      comments.removeAt(index);
      yield ReloadUIState(comments);
    }
  }

  @protected
  void reload() {
    add(LoadCommentEvent(postId));
  }

  void softAddComment(String message) {
    final account = DI.get<AuthenticationBloc>(AuthenticationBloc).account;
    final Comment item = Comment(
      createBy: account,
      createAt: DateTime.now(),
      message: message,
    );
    add(SoftAddCommentEvent(item));
  }

  void softDeleteComment(int index) {
    add(SoftDeleteCommentEvent(index));
  }
}
