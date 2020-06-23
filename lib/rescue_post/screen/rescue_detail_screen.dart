part of petisland.rescue_post.sceen;

class RescueDetailScreen extends StatefulWidget {
  static const name = '/RescueDetailScreen';

  final Rescue rescue;
  final ValueChanged<Rescue> onDeleteRescue;

  const RescueDetailScreen({
    Key key,
    @required this.rescue,
    this.onDeleteRescue,
  }) : super(key: key);

  @override
  _RescueDetailScreenState createState() => _RescueDetailScreenState();
}

class _RescueDetailScreenState extends TState<RescueDetailScreen> {
  Account get account => widget.rescue.account;
  bool get isJoined => widget.rescue.isJoined ?? false;
  bool get canJoin => widget.rescue.canJoin;
  String get id => widget.rescue.id;
  final ScrollController controller = ScrollController();
  RescueHeroBloc heroBloc;
  RescueDonateBloc donateBloc;
  RescueCommentBloc rescueCommentBloc;

  void initState() {
    super.initState();
    heroBloc = RescueHeroBloc(id)..reload();
    donateBloc = RescueDonateBloc(id)..reload();
    rescueCommentBloc = RescueCommentBloc(id)..startListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(32),
        child: PostDetailAppBar(
          hasPermision: AccountUtils.grantEditAndDel(account),
          onTapBack: () => _onTapBack(context),
          onSelected: (_) => _onTapSeeMore(context, _),
        ),
      ),
      body: BlocListener<RescueCommentBloc, CommentState>(
        bloc: rescueCommentBloc,
        condition: (_, state) => state is ScrollToBottom,
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
                  RescueDetailSummaryWidget(
                    rescue: widget.rescue,
                    heroBloc: heroBloc,
                    donateBloc: donateBloc,
                  ),
                  CommentListingWidget(
                    bloc: rescueCommentBloc,
                    onDeleteComment: _handleDeleteComment,
                  ),
                  const SizedBox(height: 150),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: isJoined
                    ? CommentInputBarWidget(onTapSend: _onTapSend)
                    : _buildJoinButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapBack(BuildContext context) {
    closeScreen(context, RescueDetailScreen.name);
  }

  void _onTapSeeMore(BuildContext context, OptionType seeMoreType) {
    switch (seeMoreType) {
      case OptionType.Report:
        _reportPost(context);
        break;
      case OptionType.Delete:
        break;
      case OptionType.Edit:
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

  void _onTapSend(String message) {
    Log.debug('SendMessage:: $message');
  }

  void _handleJoinNow() {}

  Widget _buildJoinButton() {
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
          onTap: _handleJoinNow,
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

  void _handleDeleteComment(String id) {
    Log.debug('handleDeleteComment:: $id');
    // TODO(tvc12): handle delete comment
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    rescueCommentBloc.stopListener();
  }
}
