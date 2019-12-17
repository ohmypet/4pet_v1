part of petisland.pet_feed.widget.post;

class PostWidget extends PostItemRender<Post> {
  PostWidget(Post item) : super(item);

  @override
  Widget build(BuildContext context) {
    final Widget image = Flexible(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        child: _PostImageWidget(item: item),
        alignment: Alignment.centerLeft,
      ),
    );
    final Widget description = Expanded(
      child: _buildInfo(context, item),
      flex: 5,
    );
    final buttonBar = _buildButtonBar(context, item);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Card(
        elevation: 2,
        borderOnForeground: false,
        child: Flex(
          mainAxisSize: MainAxisSize.max,
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              flex: 7,
              child: InkWell(
                onTap: () =>
                    navigateToScreen(context: context, screen: PostEditScreen.edit(item)),
                child: Flex(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  direction: Axis.horizontal,
                  children: <Widget>[
                    image,
                    description,
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: buttonBar,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context, Post item) {
    final String title = item.title;
    final Account account = item.account;
    final double price = item.price;
    final String location = item.location;
    final DateTime time = item.createAt;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(flex: 3, child: PostTitleWidget(title: title)),
          SizedBox(height: 5),
          Flexible(child: _PostUserInfoWidget(user: account?.user)),
          Flexible(child: PostMoneyWidget(price: price)),
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PostLocationWidget(location: location),
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PostTimeWidget(time: time),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonBar(BuildContext context, Post item) {
    final String phoneNumber = item.account.user?.phoneNumber?.trim();
    final double phoneOpacity = phoneNumber?.isEmpty == true ? 1 : 0.2;
    final double messageOpcaity = 1;
    final likeWidget = _PostButtonLikeWidget(item: item);
    final messageWidget = _PostButtonWidget(
      title: 'Nhắn tin',
      opacity: messageOpcaity,
      onTap: () => _message(item.account),
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

  void _message(Account account) {
    // TODO(tvc12): Setup message
  }
}

void tlaunch(String text, {LaunchMode mode = LaunchMode.Url}) async {
  String _getPrefixByMode(LaunchMode mode) {
    switch (mode) {
      case LaunchMode.Phone:
        return 'tel:';
      case LaunchMode.Message:
        return 'sms:';
      default:
        return '';
    }
  }

  final String prefix = _getPrefixByMode(mode);
  text = '$prefix$text';
  canLaunch(text)
      .then((isLaunch) => isLaunch ? launch(text) : throw Exception('cannot launch'))
      .catchError((ex) => Log.error(ex));
}

enum LaunchMode {
  Url,
  Phone,
  Message,
}
