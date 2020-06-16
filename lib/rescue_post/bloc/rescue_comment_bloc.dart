part of petisland.rescue_post.bloc;

class RescueCommentBloc extends TBloc<RescueCommentEvent, RescueCommentState> {
  final String rescueId;

  RescueCommentBloc(this.rescueId);

  @override
  Stream<RescueCommentState> errorToState(BaseErrorEvent event) async* {
  }

  @override
  Stream<RescueCommentState> eventToState(BaseEvent event) async* {
  }

  @override
  RescueCommentState get initialState => throw UnimplementedError();
}
