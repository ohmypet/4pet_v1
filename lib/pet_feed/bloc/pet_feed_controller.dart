part of petisland.petfeed.bloc;

abstract class PetFeedController {
  List<Item> getItems();

  void retrievePosts();

  void reload();

  void setListener(ValueChanged<PetFeedState> listener);

  void dispose();
}

class PetFeedControllerImpl extends PetFeedController {
  final PetFeedBloc bloc = PetFeedBloc();
  StreamSubscription<PetFeedState> _subscription;
  final List<Item> items = <Item>[];

  @protected
  ValueChanged<PetFeedState> listener;

  int get offset => items.length;
  static const int limit = 10;

  PetFeedControllerImpl() {
    _subscribe();
  }

  @override
  void setListener(ValueChanged<PetFeedState> listener) {
    this.listener = listener;
  }

  @override
  void reload() {
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
  }

  void _unsubscribe() {
    bloc.close();
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }

  @override
  List<Item> getItems() {
    return items;
  }
}
