part of petisland.rescue_post.widget;

class PreviewRescueDetailWidget extends StatelessWidget {
  final Rescue rescue;
  final TapImage onTapImage;

  const PreviewRescueDetailWidget({Key key, @required this.rescue, this.onTapImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget image = Flexible(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        child: PostImageWidget(imageUrl: rescue.firstImage),
        alignment: Alignment.center,
      ),
    );
    final Widget description = Expanded(
      child: _buildInfo(context, rescue),
      flex: 5,
    );
    return Flex(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      direction: Axis.horizontal,
      children: <Widget>[
        image,
        description,
      ],
    );
  }

  Widget _buildInfo(BuildContext context, Rescue item) {
    final String title = item.title;
    final Account account = item.account;
    final int coin = item.totalCoin;
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
          const SizedBox(height: 5),
          Flexible(child: UserInfoWidget(account: account)),
          Flexible(
            child: PostMoneyWidget(
              money: coin.toDouble(),
              typeMoney: 'coins',
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
}
