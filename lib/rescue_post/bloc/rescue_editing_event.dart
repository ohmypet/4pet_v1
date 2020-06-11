part of petisland.rescue_post.bloc;

abstract class RescueEditingEvent extends BaseEvent {}

class ChangedValue extends RescueEditingEvent {}

class ChangedImage extends RescueEditingEvent {}
