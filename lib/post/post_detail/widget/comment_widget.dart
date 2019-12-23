part of petisland.post.screen.widget;

class _CommentWidget extends StatelessWidget {
  final Comment item;

  const _CommentWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = _buildImage(context, item.createBy?.user);
    return Flex(
      mainAxisSize: MainAxisSize.max,
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(child: image, flex: 1),
        Flexible(child: _CommentDescription(item: item), flex: 7),
      ],
    );
  }

  Widget _buildImage(BuildContext context, User user) {
    final url = user?.avatar?.url != null ? user.avatar.url : null;
    final image = url != null
        ? TCacheImageWidget(url: url, shape: BoxShape.circle)
        : SvgPicture.asset(TAssets.user_avatar);
    return Container(
      margin: const EdgeInsets.all(5),
      child: AspectRatio(
        child: image,
        aspectRatio: 1,
      ),
    );
  }
}

class _CommentDescription extends StatelessWidget {
  final Comment item;

  const _CommentDescription({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final nameWidget = _buildName(context, item.createBy);
    final comment = _buildComment(context, item.message);
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(child: nameWidget, flex: 1),
        Flexible(child: comment, flex: 3)
      ],
    );
  }

  Widget _buildName(BuildContext context, Account account) {
    final String name = account.user?.name ?? '@username';
    final isPermission = grantEditAndDel(account);
    final text = DefaultTextStyle.merge(
      style: TTextStyles.bold(fontSize: 18, color: TColors.darkSkyBlue),
      child: Text(name),
    );
    if (isPermission) {
      return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(child: text),
          GestureDetector(
            onTap: _onTapDelete,
            child: Icon(Icons.delete, size: 18, color: TColors.water_melon),
          )
        ],
      );
    } else {
      return text;
    }
  }

  Widget _buildComment(BuildContext context, String message) {
    final String comment = message ?? '';
    return DefaultTextStyle.merge(
      style: TTextStyles.light(fontSize: 18, color: TColors.black.withAlpha(220)),
      child: Text(comment),
    );
  }

  void _onTapDelete() {
    Log.info('_onTapDelete:: ${item.id}');
  }
}
