part of petisland.rescue_post.widget;

class RescueActionBar extends StatefulWidget {
  final Rescue rescue;

  const RescueActionBar({Key key, @required this.rescue}) : super(key: key);

  @override
  _RescueActionBarState createState() => _RescueActionBarState();
}

class _RescueActionBarState extends State<RescueActionBar> {
  TWorker get worker => DI.get(TWorker);
  bool isLock = false;

  @override
  Widget build(BuildContext context) {
    return ActionButtonBar(
      likes: widget.rescue.getLikes(),
      isLiked: widget.rescue.isReacted ?? false,
      account: widget.rescue.account,
      onTapLike: _handleOnTapLike,
    );
  }

  void _handleOnTapLike() {
    if (isLock) return;
    isLock = true;
    worker.likeRescuePost(widget.rescue.id);
    setState(() {
      if (widget.rescue.isReacted == true) {
        widget.rescue.unLike();
      } else {
        widget.rescue.like();
      }
    });
    Future.delayed(const Duration(milliseconds: 600)).whenComplete(() {
      isLock = false;
    });
  }
}
