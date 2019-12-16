part of petisland.pet_feed.widget.post;

class _PostButtonLikeWidget extends StatefulWidget {
  final Post item;

  const _PostButtonLikeWidget({Key key, @required this.item}) : super(key: key);

  @override
  __PostButtonLikeWidgetState createState() => __PostButtonLikeWidgetState();
}

class __PostButtonLikeWidgetState extends State<_PostButtonLikeWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLike = widget.item.isReacted;
    final int likes = widget.item.likes ?? 0;
    final IconData icon = isLike ? Icons.favorite : Icons.favorite_border;
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
      icon: Icon(
        icon,
        color: theme.primaryColor,
      ),
      onPressed: () {},
    );
  }
}
