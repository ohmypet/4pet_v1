part of petisland.chat.bloc;

class ChatBloc extends TBloc<ChatEvent, ChatState> {
  FlutterWebviewPlugin flutterWebviewPlugin;
  StreamSubscription<double> _onChanged;

  String get url => _url;

  String _url;

  void setFlutterWebView(FlutterWebviewPlugin flutterWebviewPlugin) {
    this.flutterWebviewPlugin = flutterWebviewPlugin;
    _setListener();
    if (_url == null) _url = _getChatUrl();
  }

  void _setListener() {
    final NavigationBarBloc navigationBarBloc = DI.get(NavigationBarBloc);
    _onChanged = flutterWebviewPlugin.onProgressChanged.listen((_) {
      flutterWebviewPlugin
          .evalJavascript('window.location.href')
          .then((_) => _onURLChanged(navigationBarBloc, _));
    });
  }

  String _getChatUrl() {
    final Account account =
        DI.get<AuthenticationBloc>(AuthenticationBloc).account;
    return '${Config.getChatHost()}?firstAccount=${account.id}';
  }

  String _getChatDetailUrl(String secondAccount) {
    final Account account =
        DI.get<AuthenticationBloc>(AuthenticationBloc).account;
    return '${Config.getChatHost()}?firstAccount=${account.id}&secondAccount=$secondAccount';
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
    if (url?.contains('detail') == true) {
      navigationBarBloc.hide();
    } else {
      _url = _getChatUrl();
      navigationBarBloc.show();
    }
  }

  void _navigateToChatDetail(PostNavigateToChatEvent event) {
    _url = _getChatDetailUrl(event.accountId);
    flutterWebviewPlugin?.launch(_url);
  }

  void loadChatDetail(String secondAccount) {
    add(PostNavigateToChatEvent(secondAccount));
  }

  void reload() {
    flutterWebviewPlugin.reload();
  }
}
