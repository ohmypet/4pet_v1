part of petisland.post.post_detail.bloc;

class CommentBloc extends TBloc<CommentEvent, CommentState> {
  static final PostService service = DI.get(PostService);

  final List<Comment> comments = <Comment>[];

  final String postId;

  @protected
  Timer timer;

  CommentBloc(this.postId);

  void startListener() {
    timer = Timer.periodic(const Duration(seconds: 5), (_) => reload());
  }

  void stopListener() {
    if (timer.isActive) timer.cancel();
  }

  @override
  Duration get delayEvent => const Duration(milliseconds: 350);

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
      case SoftReloadEvent:
        yield* _softReload(event);
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

  Stream<CommentState> _softReload(SoftReloadEvent event) async* {
    yield ScrollToBottom();
    comments.add(event.item);
    yield ReloadUIState(comments);
  }

  @protected
  void reload() {
    add(LoadCommentEvent(postId));
  }

  void addSoftComment(String message) {
    final account = DI.get<AuthenticationBloc>(AuthenticationBloc).account;
    final Comment item = Comment(
      createBy: account,
      createAt: DateTime.now(),
      message: message,
    );
    add(SoftReloadEvent(item));
  }
}
