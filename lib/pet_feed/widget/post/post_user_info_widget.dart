part of petisland.pet_feed.widget.post;

class _PostUserInfoWidget extends StatelessWidget {
  final Account account;

  const _PostUserInfoWidget({Key key, this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget image = _buildImage(context, account?.user);
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

  Widget _buildTitle(BuildContext context, Account account) {
    final username = account.getName();
    final ThemeData theme = Theme.of(context);

    return username != null
        ? Text(
            username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w500),
          )
        : SizedBox();
  }
}
