part of petisland.petfeed.bloc;

abstract class PetFeedController {
  void retrievePost();

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
  void retrievePost() {
    bloc.retrievePosts(offset, limit);
  }

  void _handleLoadPostFailed(_LoadPostFailed state) {
    this.listener(state);
  }

  void _handleLoadPostSucceed(_LoadPostSucceed state) {
    this.items.addAll(state.newItems);
    this.listener(LoadPostSucceed(items, state.newItems != null));
  }

  @override
  void dispose() {
    _unsubscribe();
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
}
