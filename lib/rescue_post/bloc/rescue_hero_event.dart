part of petisland.rescue_post.bloc;

abstract class RescueHeroEvent extends BaseEvent {}

class LoadHeroEvent extends RescueHeroEvent {
  final String query;
  final int offset;
  final int limit;
  final bool clearOldData;

  LoadHeroEvent({
    this.query = '',
    this.offset = 0,
    this.limit = 10,
    this.clearOldData = false,
  });

  String toString() => '$runtimeType clear::$clearOldData';
}
