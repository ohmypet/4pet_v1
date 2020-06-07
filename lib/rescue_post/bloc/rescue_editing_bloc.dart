part of petisland.rescue_post.bloc;

enum RescueMode {
  Create,
  Edit,
  View,
}

class RescueEditingBloc extends TBloc<RescueEditingEvent, RescueEditingState> {
  final RescueMode mode;
  final Rescue rescue;

  RescueEditingBloc.create() : mode = RescueMode.Create, rescue = Rescue.empty();

  RescueEditingBloc.edit(this.rescue) : mode = RescueMode.Edit;

  @override
  Stream<RescueEditingState> errorToState(BaseErrorEvent event) {
    switch (event.runtimeType) {
      default:
        return null;
    }
  }

  @override
  Stream<RescueEditingState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      default:
    }
  }

  @override
  RescueEditingState get initialState => null;
}
