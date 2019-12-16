part of petisland.pet_feed.widget.post;

class _PostButtonLikeWidget extends StatefulWidget {
  final Post item;

  const _PostButtonLikeWidget({Key key, @required this.item}) : super(key: key);

  @override
  __PostButtonLikeWidgetState createState() => __PostButtonLikeWidgetState();
}

class __PostButtonLikeWidgetState extends State<_PostButtonLikeWidget> {
  bool isLook = false;
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
          style: theme.textTheme.display4
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
    setState(() {
      if (widget.item.isReacted) {
        widget.item.isReacted = false;
        --widget.item.likes;
      } else {
        widget.item.isReacted = true;
        ++widget.item.likes;
      }
    });
    Future.delayed(const Duration(milliseconds: 600)).whenComplete(() {
      isLook = false;
    });
  }
}
