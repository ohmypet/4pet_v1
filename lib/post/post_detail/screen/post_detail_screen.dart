part of petisland.post.post_detail.screen;

class PostDetailScreen extends TStatefulWidget {
  static const name = '/PostDetailScreen';
  final Post item;
  final VoidCallback onDeletePost;

  const PostDetailScreen({Key key, @required this.item, @required this.onDeletePost}) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends TState<PostDetailScreen> {
  Post get item => widget.item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(32),
        child: PostDetailAppBar(
          hasPermision: AccountUtils.grantEditAndDel(item.account),
          onTapBack: () => _onTapBack(context),
          onTapSeeMore: (_) => _onTapSeeMore(context, _),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  PostDetailSummaryWidget(item: item),
                  CommentListingWidget(item: widget.item),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CommentInputWidget(),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onTapSeeMore(BuildContext context, SeeMoreType seeMoreType) {
    switch (seeMoreType) {
      case SeeMoreType.Report:
        _reportPost(context, item);
        break;
      case SeeMoreType.Delete:
        _deletePost(context, item);
        break;
      case SeeMoreType.Edit:
        _editPost(context, item);
        break;
      default:
    }
  }

  void _reportPost(BuildContext context, Post item) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: context,
      builder: (_) => KikiReportWidget(
        onSendReport: _sendReport,
      ),
    );
  }

  void _sendReport(ReportData reportData) {
    final TWorker worker = DI.get(TWorker);
    final AuthenticationBloc bloc = DI.get(AuthenticationBloc);

    worker.report(item.id, reportData.text, bloc.account.id);
  }

  void _deletePost(BuildContext context, Post item) {
    Navigator.pop(context);
    DI.get<TWorker>(TWorker).deletePost(item.id);
    if (widget.onDeletePost != null) widget.onDeletePost();
  }

  void _editPost(BuildContext context, Post item) {
    navigateToScreen(
      context: context,
      screen: PostEditScreen.edit(item, onEditCompleted: _onSendEditPost),
      screenName: PostEditScreen.name,
    );
  }

  void _onSendEditPost(PostCreateModal post, List<PostImage> rawPostImage, List<String> urlNeedUpload,
      List<String> idImageNeedDelete) {
    reloadUI(post, rawPostImage);
    DI.get<TWorker>(TWorker).updatePost(item, urlNeedUpload, idImageNeedDelete);
  }

  void reloadUI(PostCreateModal post, List<PostImage> rawPostImage) {
    setState(() {
      item
        ..title = post.title
        ..description = post.description
        ..price = post.price
        ..location = post.location
        ..postImages.clear()
        ..postImages.addAll(rawPostImage)
        ..pet = post.pet;
    });
  }
}
