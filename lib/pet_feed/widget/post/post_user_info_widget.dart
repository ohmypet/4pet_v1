part of petisland.pet_feed.widget.post;

class _PostUserInfoWidget extends StatelessWidget {
  final User user;

  const _PostUserInfoWidget({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      final Widget image = _buildImage(context, user);
      final Widget text = _buildTitle(context, user);
      return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          image,
          SizedBox(width: 5),
          Flexible(child: text),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget _buildImage(BuildContext context, User user) {
    final url = user?.avatar?.url != null ? user.avatar.url : null;
    final image = url != null
        ? TCacheImageWidget(url: url, shape: BoxShape.circle)
        : SvgPicture.asset(TAssets.user_avatar);
    return AspectRatio(
      child: image,
      aspectRatio: 1,
    );
  }

  Widget _buildTitle(BuildContext context, User user) {
    final username = user?.name;
    final ThemeData theme = Theme.of(context);

    return username != null
        ? Text(
            username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.body2.copyWith(fontWeight: FontWeight.w500),
          )
        : SizedBox();
  }
}
