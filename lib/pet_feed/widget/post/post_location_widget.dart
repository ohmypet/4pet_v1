part of petisland.pet_feed.widget.post;

class PostLocationWidget extends StatelessWidget {
  final String location;

  const PostLocationWidget({Key key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return location?.isNotEmpty == true
        ? Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 14,
                color: theme.accentColor.withAlpha(128),
              ),
              SizedBox(width: 2),
              Text(
                location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.display4.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.accentColor.withAlpha(128),
                ),
              ),
            ],
          )
        : SizedBox();
  }
}
