part of petisland.petfeed.bloc;

@immutable
abstract class PetFeedEvent extends BaseEvent {
  @override
  String toString() => "$runtimeType";
}

class _RetrievePostEvent extends PetFeedEvent {
  final int limit;
  final int offset;
  final String categoryType;
  final String petCategoryId;

  _RetrievePostEvent(this.offset, {this.limit = 10, this.categoryType, this.petCategoryId})
      : assert(offset != null, "Offset must not null");

  @override
  String toString() => "$runtimeType offset: $offset - limit: $limit";
}

class LoadPostErrorEvent extends BaseErrorEvent implements PetFeedEvent {
  LoadPostErrorEvent(String message) : super(message);

  @override
  String toString() => "$runtimeType $message";
}

class _ReloadPostEvent extends PetFeedEvent {
  final int limit;
  final int offset;
  final String categoryType;
  final String petCategoryId;

  _ReloadPostEvent(this.offset, {this.limit = 10, this.categoryType, this.petCategoryId})
      : assert(offset != null, "Offset must not null");

  @override
  String toString() => "$runtimeType offset: $offset - limit: $limit";
}

class _LoadPostSucceedEvent extends PetFeedEvent {
  final List<Item> newItems;

  _LoadPostSucceedEvent(this.newItems);

  @override
  String toString() => "$runtimeType items: ${newItems?.length}";
}
