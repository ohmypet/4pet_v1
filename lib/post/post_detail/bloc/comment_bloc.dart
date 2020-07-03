part of petisland.post.post_detail.bloc;

class CommentBloc extends TBloc<CommentEvent, CommentState> {
  final List<Comment> comments = <Comment>[];

  final String id;

  @protected
  bool locked = false;

  @protected
  Timer timer;

  CommentBloc(this.id);

  @override
  Duration get delayEvent => const Duration(milliseconds: 50);

  @override
  CommentState get initialState => CommentStateInit();

  @override
  Stream<CommentState> errorToState(BaseErrorEvent event) {
    return null;
  }

  @override
  Stream<CommentState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case LoadCommentEvent:
        if (!locked) {
          locked = true;
          loadComment(event);
        }
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

  @protected
  FutureOr handleOnError(dynamic ex) {
    Log.error(ex);
  }

  @protected
  void loadComment(LoadCommentEvent event) {
    final PostService service = DI.get(PostService);
    service
        .getComments(event.postId)
        .then((items) {
          if (items != null) {
            if (items.isNotEmpty) {
              comments
                ..clear()
                ..addAll(items);
            }
            add(ReloadCommentUIEvent(comments));
          }
        })
        .catchError(handleOnError)
        .whenComplete(() => locked = false);
  }

  @protected
  void reload() {
    add(LoadCommentEvent(id));
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

  void softDeleteComment(String id) {
    add(SoftDeleteCommentEvent(id));
  }

  void startListener() {
    reload();
    if (timer?.isActive == true) timer.cancel();
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (locked) return;
      reload();
    });
  }

  void stopListener() {
    if (timer?.isActive == true) timer.cancel();
  }

  Stream<CommentState> _reloadUI(ReloadCommentUIEvent event) async* {
    yield ReloadUIState(event.items);
  }

  Stream<CommentState> _softAdd(SoftAddCommentEvent event) async* {
    stopListener();
    yield ScrollToBottom();
    comments.insert(0, event.item);
    yield ReloadUIState(comments);
    Future.delayed(const Duration(seconds: 5)).whenComplete(() => startListener());
  }

  Stream<CommentState> _softDelete(SoftDeleteCommentEvent event) async* {
    stopListener();

    final id = event.id;
    comments.removeWhere((item) => item.id == id);
    yield ReloadUIState(comments);
    Future.delayed(const Duration(seconds: 5)).whenComplete(() => startListener());
  }
}
