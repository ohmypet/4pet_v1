part of petisland.petfeed.bloc;

@immutable
abstract class PetFeedState extends BaseState {
  @override
  String toString() => '$runtimeType';
}

class _LoadPostFailed extends PetFeedState {
  final String message;

  _LoadPostFailed(this.message);

  @override
  String toString() => '$runtimeType $message';
}

class _LoadPostSucceed extends PetFeedState {
  final List<Item> newItems;

  _LoadPostSucceed(this.newItems);

  @override
  String toString() => '$runtimeType items: ${newItems?.length}';
}

class LoadPostSucceed extends PetFeedState {
  final List<Item> items;
  final bool maybeRetrievePost;

  LoadPostSucceed(this.items, this.maybeRetrievePost);
}

class CreatePostSuccess extends PetFeedState {}

class CreatePostError extends PetFeedState {}
