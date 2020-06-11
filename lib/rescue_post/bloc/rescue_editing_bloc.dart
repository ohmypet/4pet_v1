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

  RescueEditingBloc.edit(this.rescue) : mode = RescueMode.Edit {
    final images = rescue.images?.map((image) => image.url)?.toList() ?? [];
    oldImages.addAll(images);
  }

  @override
  Duration get delayEvent => const Duration(milliseconds: 100);

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
        break;
      default:
    }
  }

  @override
  RescueEditingState get initialState => ReloadSummaryState();

  void notifyChangedValue() {
    add(ChangedValue());
  }

  void loadImages() {
    add(ChangedImage());
  }
}
