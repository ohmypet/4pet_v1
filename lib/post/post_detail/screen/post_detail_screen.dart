part of petisland.post.post_detail.screen;

class PostDetailScreen extends TStatefulWidget {
  static const name = '/PostDetailScreen';
  final Post item;
  final VoidCallback onDeletePost;

  const PostDetailScreen({Key key, @required this.item, @required this.onDeletePost})
      : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends TState<PostDetailScreen> {
  final TWorker worker = DI.get<TWorker>(TWorker);
  CommentBloc bloc;
  final ScrollController controller = ScrollController();
  Post get item => widget.item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(32),
        child: PostDetailAppBar(
          isOwner: AccountUtils.isOwner(item.account),
          onTapBack: () => _onTapBack(context),
          onSelected: (_) => _onTapSeeMore(context, _),
        ),
      ),
      body: BlocListener<CommentBloc, CommentState>(
        bloc: bloc,
        listener: _onCommentChanged,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                controller: controller,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  PostDetailSummaryWidget(item: item),
                  CommentListingWidget(
                    bloc: bloc,
                    onDeleteComment: handleDeleteCommnet,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CommentInputBarWidget(
                  onTapSend: _onTapSend,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.stopListener();
  }

  void handleDeleteCommnet(String id) {
    DI.get<TWorker>(TWorker).deleteComment(bloc.id, id);
  }

  void initState() {
    super.initState();
    bloc = CommentBloc(item.id)..startListener();
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

  void _deletePost(BuildContext context, Post item) {
    Navigator.pop(context);
    worker.deletePost(item.id);
    if (widget.onDeletePost != null) widget.onDeletePost();
  }

  void _editPost(BuildContext context, Post item) {
    navigateToScreen(
      context: context,
      screen: PostEditScreen.edit(item, onEditCompleted: _onSendEditPost),
      screenName: PostEditScreen.name,
    );
  }

  void _onCommentChanged(BuildContext context, CommentState state) {
    if (state is ScrollToBottom) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 150),
        curve: Curves.bounceIn,
      );
    }
  }

  void _onSendEditPost(PostCreateModal post, List<PostImage> rawPostImage,
      List<String> urlNeedUpload, List<String> idImageNeedDelete) {
    reloadUI(post, rawPostImage);
    worker.updatePost(item, urlNeedUpload, idImageNeedDelete);
  }

  void _onTapBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onTapSeeMore(BuildContext context, OptionType seeMoreType) {
    switch (seeMoreType) {
      case OptionType.Report:
        _reportPost(context, item);
        break;
      case OptionType.Delete:
        _deletePost(context, item);
        break;
      case OptionType.Edit:
        _editPost(context, item);
        break;
      default:
    }
  }

  void _onTapSend(String message) {
    worker.commentPost(item.id, message);
    bloc.softAddComment(message);
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
    final AuthenticationBloc bloc = DI.get(AuthenticationBloc);

    worker.report(item.id, reportData.text, bloc.account.id);
  }
}
