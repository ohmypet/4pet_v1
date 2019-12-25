part of petisland.chat.bloc;

abstract class ChatEvent extends BaseEvent {}

class PostNavigateToChatEvent extends ChatEvent {
  final String accountId;

  PostNavigateToChatEvent(this.accountId);
}
