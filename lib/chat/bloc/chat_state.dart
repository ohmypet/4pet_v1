part of petisland.chat.bloc;

abstract class ChatState extends BaseState {}

class InitChatState extends ChatState {}

class LoadChat extends ChatState {
  final String url;

  LoadChat(this.url);
}
