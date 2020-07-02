part of petisland.pet_feed.widget.post;

class UserInfoWidget extends StatelessWidget {
  final Account account;

  const UserInfoWidget({Key key, this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget image = _buildImage(context, account.user?.avatar?.url);
    final Widget text = _buildTitle(context, account);
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
  }

  Widget _buildImage(BuildContext context, String url) {
    return AspectRatio(
      child: CircleColorWidget(
        padding: const EdgeInsets.all(1),
        child: AvatarWidget(
          url: url,
          paddingDefaultImage: const EdgeInsets.all(1),
        ),
      ),
      aspectRatio: 1,
    );
  }

  Widget _buildTitle(BuildContext context, Account account) {
    final username = account.getName();
    final ThemeData theme = Theme.of(context);

    return username != null
        ? Text(
            username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w500),
          )
        : SizedBox();
  }
}
