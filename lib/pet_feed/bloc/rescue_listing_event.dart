part of petisland.petfeed.bloc;

abstract class RescueListingEvent extends BaseEvent {}

class LoadMoreRescueEvent extends RescueListingEvent {
  final String query;
  final int from;
  final int limit;

  LoadMoreRescueEvent({this.query = '', this.from = 0, this.limit = 10})
      : assert(query != null, 'Query is not null'),
        assert(from != null, 'From is not null'),
        assert(limit != null, 'Limit is not null');
}

class RefreshResuceListingEvent extends LoadMoreRescueEvent {
  RefreshResuceListingEvent({String query = '', int from = 0, int limit = 10})
      : super(
          query: query,
          from: from,
          limit: limit,
        );
}
