part of petisland.pet_feed.widget.post;

class ActionButtonBar extends TStatelessWidget {
  final Account account;
  final int likes;
  final bool isLiked;
  final VoidCallback onTapLike;

  const ActionButtonBar({
    Key key,
    this.account,
    @required this.likes,
    @required this.isLiked,
    this.onTapLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = account?.user?.phoneNumber?.trim();
    final double phoneOpacity = phoneNumber?.isNotEmpty == true ? 1 : 0.2;
    final double messageOpcaity = 1;
    final likeWidget = PostButtonLikeWidget(
      likes: likes,
      isReacted: isLiked,
      onTapLike: onTapLike,
    );
    final messageWidget = _PostButtonWidget(
      title: 'Chat',
      opacity: messageOpcaity,
      onTap: () => _message(context, account),
      icon: Icon(
        Icons.question_answer,
        color: TColors.light_blue,
      ),
    );
    final callWidget = _PostButtonWidget(
      title: 'Call Now',
      opacity: phoneOpacity,
      onTap: () => _call(phoneNumber),
      icon: Icon(
        Icons.phone_in_talk,
        color: TColors.dark_sky_blue,
      ),
    );

    return _PostButtonBarWidget(
      children: <Widget>[
        Expanded(child: likeWidget),
        Expanded(child: callWidget),
        Expanded(child: messageWidget),
      ],
    );
  }

  void _call(String phoneNumber) {
    tlaunch(phoneNumber, mode: LaunchMode.Phone);
  }

  void _message(BuildContext context, Account account) {
    if (account?.id?.isNotEmpty == true) {
      Log.info('_message:: ${account.id}');
      closeUntil(context, '/');
      DI.get<NavigationBarBloc>(NavigationBarBloc).navigationTo(Tabs.Messenger);
      DI.get<ChatBloc>(ChatBloc).loadChatDetail(account.id);
    }
  }
}
