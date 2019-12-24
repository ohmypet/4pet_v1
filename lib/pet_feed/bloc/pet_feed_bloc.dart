part of petisland.petfeed.bloc;

class PetFeedBloc extends TBloc<PetFeedEvent, PetFeedState> {
  static final PostService postService = DI.get(PostService);

  @override
  Duration get delayEvent => const Duration(milliseconds: 150);

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

  void _handleLoadPostSucceed(List<Item> items) {
    add(_LoadPostSucceedEvent(items));
  }

  void _handleError(dynamic ex, trace) {
    Log.error('$ex - $trace');
    add(LoadPostErrorEvent('Lấy bài đăng bị lỗi, thử lại sau'));
  }

  @override
  PetFeedState get initialState => LoadPostSucceed(<Item>[], true);

  void retrievePosts(int offset, int limit) {
    add(_RetrievePostEvent(offset, limit: limit));
  }

  void reloadPosts(int offset, int limit) {
    add(_ReloadPostEvent(offset, limit: limit));
  }
}
