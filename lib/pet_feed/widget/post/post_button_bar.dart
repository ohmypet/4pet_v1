part of petisland.pet_feed.widget.post;

class PostButtonBar extends TStatelessWidget {
  final Post item;

  final VoidCallback onTapPost;

  const PostButtonBar({Key key, @required this.item, this.onTapPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = item.account.user?.phoneNumber?.trim();
    final double phoneOpacity = phoneNumber?.isEmpty == true ? 1 : 0.2;
    final double messageOpcaity = 1;
    final likeWidget = PostButtonLikeWidget(item: item);
    final messageWidget = _PostButtonWidget(
      title: 'Nhắn tin',
      opacity: messageOpcaity,
      onTap: () => _message(context, item.account),
      icon: Icon(
        Icons.message,
        color: TColors.green,
      ),
    );
    final callWidget = _PostButtonWidget(
      title: 'Gọi ngay',
      opacity: phoneOpacity,
      onTap: () => _call(phoneNumber),
      icon: Icon(
        Icons.call,
        color: Colors.blue,
      ),
    );

    return _PostButtonBarWidget(
      children: <Widget>[
        Expanded(child: likeWidget),
        Expanded(child: messageWidget),
        Expanded(child: callWidget),
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
