part of petisland.notification;

class PostLoadingScreen extends StatefulWidget {
  static const String name = '/PostLoadingScreen';
  final String id;

  const PostLoadingScreen({Key key, @required this.id}) : super(key: key);
  @override
  _PostLoadingScreenState createState() => _PostLoadingScreenState();
}

class _PostLoadingScreenState extends State<PostLoadingScreen> {
  final PostService service = DI.get(PostService);

  @override
  void initState() {
    super.initState();

    service.getPost(widget.id).then(_handleResult).catchError(_handleError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoadingWidget());
  }

  void _handleError(dynamic ex) {
    Log.error(ex);
    Navigator.pop<PopResult>(context, PopResult.Failure);
  }

  FutureOr _handleResult(Post value) {
    Navigator.pushReplacement(
      context,
      TPageRoute(
        builder: (_) => PostDetailScreen(
          item: value,
          onDeletePost: () {},
        ),
        settings: RouteSettings(name: PostDetailScreen.name),
      ),
    );
  }
}
