part of petisland.pet_feed.widget.post;

class PostButtonBar extends StatefulWidget {
  final Post item;

  const PostButtonBar({Key key, @required this.item}) : super(key: key);

  @override
  _PostButtonBarState createState() => _PostButtonBarState();
}

class _PostButtonBarState extends State<PostButtonBar> {
  Post get item => widget.item;
  bool isLock = false;
  TWorker get worker => DI.get(TWorker);
  @override
  Widget build(BuildContext context) {
    return ActionButtonBar(
      account: item.account,
      isLiked: item.isReacted,
      likes: item.getLikes(),
      onTapLike: _handleOnTapLike,
      
    );
  }

  void _handleOnTapLike() {
    if (isLock) return;
    isLock = true;
    worker.likePost(widget.item.id);
    setState(() {
      if (widget.item.isReacted) {
        widget.item.unLike();
      } else {
        widget.item.like();
      }
    });
    Future.delayed(const Duration(milliseconds: 600)).whenComplete(() {
      isLock = false;
    });
  }
}
