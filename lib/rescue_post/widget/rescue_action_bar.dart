part of petisland.rescue_post.widget;

class RescueActionBar extends StatefulWidget {
  final Rescue rescue;

  const RescueActionBar({Key key, @required this.rescue}) : super(key: key);

  @override
  _RescueActionBarState createState() => _RescueActionBarState();
}

class _RescueActionBarState extends State<RescueActionBar> {
  @override
  Widget build(BuildContext context) {
    return ActionButtonBar(
      likes: widget.rescue.likes ?? 0,
      isLiked: widget.rescue.isLiked ?? false,
      account: widget.rescue.account,
      onTapLike: _onTapLike,
    );
  }

  void _onTapLike() {}
}
