part of petisland.profile.bloc.my_post;

class MyPostBloc extends TBloc<MyPostEvent, MyPostState> {
  static final PostService service = DI.get(PostService);
  final List<PanelDetail> posts = [];
  final int limit = 15;

  @override
  Duration get delayEvent => const Duration(milliseconds: 150);

  @override
  MyPostState get initialState => InitMyPostState();

  @protected
  int get offset => posts.length;

  @override
  Stream<MyPostState> errorToState(BaseErrorEvent event) {
    return null;
  }

  @override
  Stream<MyPostState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case _ReloadMyPostEvent:
        _reloadMyPost(event);
        break;
      case _ReloadUIEvent:
        yield ReloadMyPost((event as _ReloadUIEvent).items);
        break;
      case _RetrieveMyPostEvent:
        _retrievePosts(event);
        break;
      default:
    }
  }

  void reload() {
    add(_ReloadMyPostEvent(offset, limit));
  }

  void retrievePost() {
    add(_RetrieveMyPostEvent(offset, limit));
  }

  void _handleError(dynamic ex) {
    Log.error(ex);
    add(_ReloadUIEvent(posts));
  }

  void _reloadMyPost(_ReloadMyPostEvent event) {
    FutureOr _reloadUI(List<PanelDetail> value) {
      if (value.isNotEmpty) {
        posts
          ..clear()
          ..addAll(value);
      }
      add(_ReloadUIEvent(posts));
    }

    service
        .getMyPost(offset: event.offset, limit: event.limit)
        .then(_reloadUI)
        .catchError(_handleError);
  }

  void _retrievePosts(_RetrieveMyPostEvent event) {
    FutureOr _reloadUI(List<PanelDetail> items) {
      if (items.isNotEmpty) {
        posts.addAll(items);
      }
      add(_ReloadUIEvent(posts));
    }

    service
        .getMyPost(offset: event.offset, limit: event.limit)
        .then(_reloadUI)
        .catchError(_handleError);
  }
}
