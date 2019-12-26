part of petisland.profile.bloc.favorite_post;

class FavoritePostBloc extends TBloc<FavoritePostEvent, FavoritePostState> {
  static final PostService service = DI.get(PostService);
  final List<PanelDetail> posts = [];
  final int limit = 15;

  @protected
  int get offset => posts.length;

  @override
  Duration get delayEvent => const Duration(milliseconds: 150);

  @override
  Stream<FavoritePostState> errorToState(BaseErrorEvent event) {
    return null;
  }

  @override
  Stream<FavoritePostState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case _ReloadFavoritePostEvent:
        _reloadMyPost(event);
        break;
      case _ReloadUIEvent:
        yield ReloadFavoritePost((event as _ReloadUIEvent).items);
        break;
      case _RetrieveFavoritePostEvent:
        _retrievePosts(event);
        break;
      default:
    }
  }

  @override
  FavoritePostState get initialState => IniFavoritePostState();

  void _reloadMyPost(_ReloadFavoritePostEvent event) {
    FutureOr _reloadUI(List<PanelDetail> value) {
      if (value.isNotEmpty) {
        posts
          ..clear()
          ..addAll(value);
      }
      add(_ReloadUIEvent(posts));
    }

    service
        .getFavoritePosts(offset: event.offset, limit: event.limit)
        .then(_reloadUI)
        .catchError(_handleError);
  }

  void _retrievePosts(_RetrieveFavoritePostEvent event) {
    FutureOr _reloadUI(List<PanelDetail> items) {
      if (items.isNotEmpty) {
        posts.addAll(items);
      }
      add(_ReloadUIEvent(posts));
    }

    service
        .getFavoritePosts(offset: event.offset, limit: event.limit)
        .then(_reloadUI)
        .catchError(_handleError);
  }

  void _handleError(dynamic ex) {
    Log.error(ex);
    add(_ReloadUIEvent(posts));
  }

  void reload() {
    add(_ReloadFavoritePostEvent(offset, limit));
  }

  void retrievePost() {
    add(_RetrieveFavoritePostEvent(offset, limit));
  }
}
