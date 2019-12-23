part of petisland.message;

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final firstAccount = '6dc14848-0380-4211-b4f5-88335e8355bd';
    final seccondAccount = '7ea44efa-b307-40ce-9056-b4785d3a0c99';
    final url =
        'https://chat-plugin.now.sh/?firstAccount=$firstAccount&secondAccount=$seccondAccount';
    return SafeArea(
//      key: PageStorageKey('chat'),
      child: WebviewScaffold(url: url),
    );
  }
}