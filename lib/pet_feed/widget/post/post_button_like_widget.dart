part of petisland.pet_feed.widget.post;

class PostButtonLikeWidget extends StatefulWidget {
  final Post item;

  const PostButtonLikeWidget({Key key, @required this.item}) : super(key: key);

  @override
  _PostButtonLikeWidgetState createState() => _PostButtonLikeWidgetState();
}

class _PostButtonLikeWidgetState extends State<PostButtonLikeWidget> {
  bool isLook = false;
  final TWorker worker = DI.get(TWorker);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLike = widget.item.isReacted;
    final int likes = widget.item.getLikes();
    final Widget icon = isLike ? animationLike() : defaultIcon();
    return FlatButton.icon(
      padding: EdgeInsets.zero,
      label: Flexible(
        child: Text(
          '$likes thích',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.headline1
              .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      icon: icon,
      onPressed: _onTapLikes,
    );
  }

  Widget defaultIcon() {
    final ThemeData theme = Theme.of(context);
    return Icon(
      Icons.favorite_border,
      color: theme.primaryColor,
    );
  }

  Widget animationLike() {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      width: 24,
      child: AspectRatio(
        aspectRatio: 1,
        child: FlareActor(
          TAssets.flare_like,
          animation: 'like_blast',
          snapToEnd: false,
          fit: BoxFit.cover,
          sizeFromArtboard: false,
          shouldClip: true,
          color: theme.primaryColor,
        ),
      ),
    );
  }

  void _onTapLikes() {
    if (isLook) return;
    isLook = true;
    worker.likePost(widget.item.id);
    setState(() {
      if (widget.item.isReacted) {
        widget.item.unLike();
      } else {
        widget.item.like();
      }
    });
    Future.delayed(const Duration(milliseconds: 600)).whenComplete(() {
      isLook = false;
    });
  }
}
