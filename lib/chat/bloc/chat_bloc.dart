part of petisland.chat.bloc;

class ChatBloc extends TBloc<ChatEvent, ChatState> {
  FlutterWebviewPlugin flutterWebviewPlugin;
  StreamSubscription<double> _onChanged;
  String get url => _url;
  String _url;

  void setFlutterWebView(FlutterWebviewPlugin flutterWebviewPlugin) {
    this.flutterWebviewPlugin = flutterWebviewPlugin;
    _setListener();
    if (_url == null) _setFirstJoinInChat();
  }

  void _setListener() {
    final NavigationBarBloc navigationBarBloc = DI.get(NavigationBarBloc);
    _onChanged = flutterWebviewPlugin.onProgressChanged.listen((_) {
      flutterWebviewPlugin
          .evalJavascript('window.location.href')
          .then((_) => _onURLChanged(navigationBarBloc, _));
    });
  }

  void _setFirstJoinInChat() {
    final Account account = DI.get<AuthenticationBloc>(AuthenticationBloc).account;
    _url = 'https://chat-plugin.now.sh?firstAccount=${account.id}';
  }

  void _setUrl(String secondAccount) {
    final Account account = DI.get<AuthenticationBloc>(AuthenticationBloc).account;
    _url =
        'https://chat-plugin.now.sh/?firstAccount=${account.id}&secondAccount=$secondAccount';
  }

  @override
  Duration get delayEvent => const Duration(milliseconds: 150);

  @override
  Stream<ChatState> errorToState(BaseErrorEvent event) {
    return null;
  }

  @override
  Stream<ChatState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case PostNavigateToChatEvent:
        _navigateToChatDetail(event);
        break;
      default:
    }
  }

  @override
  ChatState get initialState => InitChatState();

  void removePlugin() {
    _onChanged?.cancel();
    flutterWebviewPlugin = null;
  }

  FutureOr _onURLChanged(NavigationBarBloc navigationBarBloc, String url) {
    _url = url;
    Log.info('current url:: $url');
    if (url?.contains('detail') == true) {
      navigationBarBloc.hide();
    } else
      navigationBarBloc.show();
  }

  void _navigateToChatDetail(PostNavigateToChatEvent event) {
    _setUrl(event.accountId);
    flutterWebviewPlugin?.launch(_url);
  }

  void loadChatDetail(String secondAccount) {
    add(PostNavigateToChatEvent(secondAccount));
  }
}
