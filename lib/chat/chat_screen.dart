part of petisland.message;

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FlutterWebviewPlugin plugin = FlutterWebviewPlugin();
  ChatBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = DI.get<ChatBloc>(ChatBloc)..setFlutterWebView(plugin);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebviewScaffold(
        key: scaffoldKey,
        url: bloc.url,
        withJavascript: true,
        withLocalStorage: true,
        appCacheEnabled: false,
        scrollBar: false,
      ),
    );
  }

  @override
  void dispose() {
    bloc.removePlugin();
    plugin.close();

    super.dispose();
  }
}
