part of petisland.petfeed.bloc;

abstract class PetFeedController {
  List<Item> getItems();

  void retrievePosts();

  void reload();

  void clear();

  void remove(String id);

  void setListener(ValueChanged<PetFeedState> listener);

  void dispose();
}

class PetFeedControllerImpl extends PetFeedController {
  final PetFeedBloc bloc = PetFeedBloc();
  StreamSubscription<PetFeedState> _subscription;
  StreamSubscription<WorkerState> _subscriptionWorker;

  final List<Item> items = <Item>[];
  final TWorker worker;

  @protected
  ValueChanged<PetFeedState> listener;

  int get offset => items.length;
  static const int limit = 10;

  PetFeedControllerImpl(this.worker) {
    _subscribe();
  }

  @override
  void setListener(ValueChanged<PetFeedState> listener) {
    this.listener = listener;
  }

  @override
  void reload() {
    items.clear();
    bloc.reloadPosts(offset, limit);
  }

  @override
  void retrievePosts() {
    bloc.retrievePosts(offset, limit);
  }

  void _handleLoadPostFailed(_LoadPostFailed state) {
    this.listener(state);
  }

  void _handleLoadPostSucceed(_LoadPostSucceed state) {
    this.items.addAll(state.newItems);
    this.listener(LoadPostSucceed(items, state.newItems.isNotEmpty));
  }

  @override
  void dispose() {
    _unsubscribe();
    items.clear();
  }

  void _subscribe() {
    _subscription = bloc.skip(1).listen((PetFeedState state) {
      if (state is _LoadPostFailed) {
        _handleLoadPostFailed(state);
      } else if (state is _LoadPostSucceed) {
        _handleLoadPostSucceed(state);
      }
    });

    _subscriptionWorker = worker.skip(1).listen((WorkerState state) {
      if (state is UploadPostSuccess) {
        this.listener(CreatePostSuccess(state.message));
        reload();
      }
      if (state is UploadFailedEvent) this.listener(CreatePostError());
    });
  }

  void _unsubscribe() {
    bloc.close();
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
    if (_subscriptionWorker != null) {
      _subscriptionWorker.cancel();
      _subscription = null;
    }
  }

  @override
  List<Item> getItems() {
    return items;
  }

  @override
  void clear() {
    items.clear();
  }

  @override
  void remove(String id) {
    items.removeWhere((item) {
      if (item is PanelDetail && item.postItem is Post) {
        final Post post = item.postItem;
        return post.id == id;
      } else if (item is Panel) {
        // TODO(tvc12): remove item is trending
      }
      return false;
    });
    this.listener(LoadPostSucceed(items, true));
  }
}
