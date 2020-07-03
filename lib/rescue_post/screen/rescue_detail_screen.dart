part of petisland.rescue_post.sceen;

class RescueDetailScreen extends StatefulWidget {
  static const name = '/RescueDetailScreen';

  final Rescue rescue;

  const RescueDetailScreen({Key key, @required this.rescue}) : super(key: key);

  @override
  _RescueDetailScreenState createState() => _RescueDetailScreenState();
}

class _RescueDetailScreenState extends TState<RescueDetailScreen> {
  Account get rescueAccount => widget.rescue.account;
  bool get isJoined => isOwner || (widget.rescue.isJoined ?? false);
  bool get canJoin => !isOwner && widget.rescue.canJoin;
  String get rescueId => widget.rescue.id;
  final ScrollController controller = ScrollController();
  RescueHeroBloc heroBloc;
  RescueDonateBloc donateBloc;
  RescueCommentBloc rescueCommentBloc;
  RescueService get rescueService => DI.get(RescueService);
  RescueListingBloc get listingBloc => DI.get(RescueListingBloc);
  bool get isOwner => AccountUtils.isOwner(rescueAccount);
  bool get showLeave => widget.rescue.isJoined ?? false;

  bool isLoading = false;

  void initState() {
    super.initState();
    heroBloc = RescueHeroBloc(rescueId)..reload();
    donateBloc = RescueDonateBloc(rescueId); //..reload();
    rescueCommentBloc = RescueCommentBloc(rescueId)..startListener();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(32),
            child: Builder(
              builder: (context) => PostDetailAppBar(
                showLeave: showLeave,
                isOwner: isOwner,
                onTapBack: () => _onTapBack(context),
                onSelected: (_) => _onTapSeeMore(context, _),
                showReport: false,
              ),
            ),
          ),
          body: BlocListener<RescueCommentBloc, CommentState>(
            bloc: rescueCommentBloc,
            condition: (_, state) => state is ScrollToBottom,
            listener: _onCommentChanged,
            child: Builder(
              builder: (context) => SafeArea(
                child: Stack(
                  children: <Widget>[
                    ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      controller: controller,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: <Widget>[
                        RescueDetailSummaryWidget(rescue: widget.rescue),
                        const SizedBox(height: 5),
                        HeroListingWidget(
                          heroBloc: heroBloc,
                          maxHeroeAsString: widget.rescue.maxHeroeAsString,
                        ),
                        SponsorListingWidget(donateBloc: donateBloc),
                        CommentListingWidget(
                          bloc: rescueCommentBloc,
                          onDeleteComment: (_) => _handleDeleteComment(context, _),
                        ),
                        const SizedBox(height: 150),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: isJoined
                          ? CommentInputBarWidget(
                              onTapSend: (_) => _onTapSend(context, _),
                            )
                          : _buildJoinButton(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        isLoading ? LoadingWidget() : const SizedBox()
      ],
    );
  }

  void _onTapBack(BuildContext context) {
    closeScreen(context, RescueDetailScreen.name);
  }

  void _onTapSeeMore(BuildContext context, OptionType seeMoreType) {
    switch (seeMoreType) {
      case OptionType.Report:
        return;
        // TODO(tvc12): send report
        _reportPost(context);
        break;
      case OptionType.Delete:
        _deleteRescue(context);
        break;
      case OptionType.Edit:
        _editRescue(context);
        break;
      case OptionType.Leave:
        _handleLeaveRescue(context);
        break;
      default:
    }
  }

  void _reportPost(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: context,
      builder: (_) => KikiReportWidget(
        onSendReport: _sendReport,
      ),
    );
  }

  void _sendReport(ReportData value) {
    Log.debug('Seleted:: $value');
  }

  void _onTapSend(BuildContext context, String message) {
    Log.info('SendMessage:: $message');
    rescueCommentBloc
      ..softAddComment(message)
      ..stopListener();
    rescueService
        .addComment(rescueId, message)
        .catchError(
          (ex) => this.showErrorSnackBar(
            context: context,
            content: TConstants.error,
          ),
        )
        .whenComplete(() => rescueCommentBloc.startListener());
  }

  void _handleJoinNow(BuildContext context) async {
    setState(() => isLoading = true);
    rescueService
        .join(widget.rescue.id)
        .then((value) => widget.rescue.join())
        .then((value) => this.heroBloc.reload())
        .catchError(
          (ex) => this.showErrorSnackBar(
            context: context,
            content: TConstants.error,
          ),
        )
        .whenComplete(() => this.setState(() => isLoading = false));
  }

  Widget _buildJoinButton(BuildContext context) {
    if (canJoin) {
      return Container(
        height: 65,
        decoration: BoxDecoration(
          boxShadow: TShadows.innerShadow,
          color: TColors.text_white,
          borderRadius: TConstants.border_top_left,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: PetIslandButtonWidget(
          text: TConstants.join_now,
          onTap: () => _handleJoinNow(context),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  void _onCommentChanged(BuildContext context, state) {
    if (mounted)
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 150),
        curve: Curves.bounceIn,
      );
  }

  void _handleDeleteComment(BuildContext context, String commentId) {
    rescueCommentBloc.stopListener();
    rescueService
        .deleteComment(rescueId, commentId)
        .catchError(
          (ex) => this.showErrorSnackBar(
            context: context,
            content: TConstants.error,
          ),
        )
        .whenComplete(() => rescueCommentBloc.startListener());
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    rescueCommentBloc.stopListener();
  }

  void _deleteRescue(BuildContext context) async {
    this.setState(() => isLoading = true);

    rescueService
        .delete(widget.rescue.id)
        .then((value) => listingBloc.refreshRescuePost())
        .then((value) => this.closeScreen(context, RescueDetailScreen.name))
        .catchError(
          (ex) => {
            this.setState(() => isLoading = false),
            this.showErrorSnackBar(
              context: context,
              content: TConstants.error,
            )
          },
        );
  }

  void _editRescue(BuildContext context) {
    navigateToScreen(
      context: context,
      screen: RescueEditorScreen.edit(rescue: widget.rescue),
    );
  }

  void _handleLeaveRescue(BuildContext context) {
    this.setState(() => isLoading = true);

    rescueService
        .unJoin(widget.rescue.id)
        .then((value) => widget.rescue.unJoin())
        .then((value) => this.heroBloc.reload())
        .catchError(
          (ex) => this.showErrorSnackBar(
            context: context,
            content: TConstants.error,
          ),
        )
        .whenComplete(() => this.setState(() => isLoading = false));
  }
}
