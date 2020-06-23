part of petisland.pet_feed.widget.post;

class PostButtonLikeWidget extends StatelessWidget {
  final bool isReacted;
  final int likes;
  final VoidCallback onTapLike;

  PostButtonLikeWidget({
    Key key,
    @required this.isReacted,
    @required this.likes,
    this.onTapLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget icon = this.isReacted ? animationLike(context) : defaultIcon(context);
    return FlatButton.icon(
      padding: EdgeInsets.zero,
      label: Flexible(
        child: Text(
          '$likes Like',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.headline1
              .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      icon: icon,
      onPressed: onTapLike,
    );
  }

  Widget defaultIcon(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Icon(
      Icons.favorite_border,
      color: theme.primaryColor,
    );
  }

  Widget animationLike(BuildContext context) {
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
}
