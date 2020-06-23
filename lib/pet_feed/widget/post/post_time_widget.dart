part of petisland.pet_feed.widget.post;

class PostTimeWidget extends StatelessWidget {
  final DateTime time;

  const PostTimeWidget({Key key, this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return time != null
        ? Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Icon(
                Icons.timer,
                size: 14,
                color: theme.accentColor.withAlpha(128),
              ),
              const SizedBox(width: 2),
              Text(
                TimeUtils.getTimeAgo(time),
                style: theme.textTheme.headline1.copyWith(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: theme.accentColor.withAlpha(128),
                    height: 1.2),
              ),
            ],
          )
        : SizedBox();
  }
}
