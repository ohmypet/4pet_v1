part of petisland.rescue_post.bloc;

enum RescueMode {
  Create,
  Edit,
  View,
}

class RescueEditingBloc extends TBloc<RescueEditingEvent, RescueEditingState> {
  final RescueMode mode;
  final Rescue rescue;
  final oldImages = <String>[];
  final newImages = <String>[];

  RescueEditingBloc.create()
      : mode = RescueMode.Create,
        rescue = Rescue.empty();

  RescueEditingBloc.edit(Rescue rescue)
      : this.rescue = rescue.clone(),
        mode = RescueMode.Edit {
    final images =
        rescue.rescueImages?.map((rescueImage) => rescueImage.url)?.toList() ?? [];
    oldImages.addAll(images);
  }

  final delayEvent = const Duration(milliseconds: 50);

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
      case ChangedValue:
        yield ReloadSummaryState();
        break;
      case ChangedImage:
        yield ReloadImageSlider();
        yield ReloadSummaryState();
        break;
      default:
    }
  }

  @override
  RescueEditingState get initialState => ReloadSummaryState();

  void reloadSummaryInfo() {
    add(ChangedValue());
  }

  void reloadImageSlider() {
    add(ChangedImage());
  }
}
