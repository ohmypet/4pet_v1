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

class _RescueDetailScreenState extends State<RescueDetailScreen> {
  Account get account => widget.rescue.account;
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
    );
  }

  void _onTapBack(BuildContext context) {}

  void _onTapSeeMore(BuildContext context, OptionType seeMoreType) {}
}
