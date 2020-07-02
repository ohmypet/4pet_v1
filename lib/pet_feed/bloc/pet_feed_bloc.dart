part of petisland.petfeed.bloc;

class PetFeedBloc extends TBloc<PetFeedEvent, PetFeedState> {
  static final PostService postService = DI.get(PostService);

  @override
  Duration get delayEvent => const Duration(milliseconds: 150);

  @override
  PetFeedState get initialState => LoadPostSucceed(<Item>[], true);

  @override
  Stream<PetFeedState> errorToState(BaseErrorEvent event) async* {
    switch (event.runtimeType) {
      case LoadPostErrorEvent:
        yield _LoadPostFailed(event.message);
    }
  }

  @override
  Stream<PetFeedState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case _RetrievePostEvent:
        _retrievePosts(event);
        break;
      case _ReloadPostEvent:
        _reloadPosts(event);
        break;
      case _LoadPostSucceedEvent:
        final _LoadPostSucceedEvent succeedEvent = event;
        yield _LoadPostSucceed(succeedEvent.newItems);
        break;
    }
  }

  void reloadPosts(int offset, int limit) {
    add(_ReloadPostEvent(offset, limit: limit));
  }

  void retrievePosts(int offset, int limit) {
    add(_RetrievePostEvent(offset, limit: limit));
  }

  void _handleError(dynamic ex, trace) {
    Log.error('$ex - $trace');
    add(LoadPostErrorEvent('Get post error, try again later!'));
  }

  void _handleLoadPostSucceed(List<Item> items) {
    add(_LoadPostSucceedEvent(items));
  }

  void _reloadPosts(_ReloadPostEvent event) {
    postService
        .getPosts(
          event.offset,
          limit: event.limit,
          categoryType: event.categoryType,
          petCategoryId: event.petCategoryId,
        )
        .then(_handleLoadPostSucceed)
        .catchError(_handleError);
  }

  void _retrievePosts(_RetrievePostEvent event) {
    postService
        .getPosts(
          event.offset,
          limit: event.limit,
          categoryType: event.categoryType,
          petCategoryId: event.petCategoryId,
        )
        .then(_handleLoadPostSucceed)
        .catchError(_handleError);
  }
}
