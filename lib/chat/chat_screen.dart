part of petisland.message;

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final url = 'https://github.com/tvc12';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
//      key: PageStorageKey('chat'),
      child: WebviewScaffold(
        url: url,
      ),
    );
  }
}
