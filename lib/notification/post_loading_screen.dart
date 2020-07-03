part of petisland.notification;

class PostLoadingScreen extends StatefulWidget {
  static const String name = '/PostLoadingScreen';
  final String id;
  final String type;

  const PostLoadingScreen({Key key, @required this.id, this.type}) : super(key: key);

  @override
  _PostLoadingScreenState createState() => _PostLoadingScreenState();
}

class _PostLoadingScreenState extends State<PostLoadingScreen> {
  PostService get postService => DI.get(PostService);
  RescueService get rescueService => DI.get(RescueService);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoadingWidget());
  }

  void _handleError(dynamic ex) {
    Log.error(ex);
    Navigator.pop<PopResult>(context, PopResult.Failure);
  }

  FutureOr _navigatePost(Post value) {
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

  void loadData() {
    switch (widget.type.toUpperCase()) {
      case 'post':
        rescueService.getRescue(widget.id).then(_navigateRescue).catchError(_handleError);
        break;

      case 'rescue':
        postService.getPost(widget.id).then(_navigatePost).catchError(_handleError);
        break;
      default:
    }
  }

  FutureOr _navigateRescue(Rescue value) {
    Navigator.pushReplacement(
      context,
      TPageRoute(
        builder: (_) => RescueDetailScreen(rescue: value),
        settings: RouteSettings(name: RescueDetailScreen.name),
      ),
    );
  }
}
