part of petisland.post.screen.widget;

class _CommentWidget extends StatelessWidget {
  final Comment item;
  final VoidCallback onTapDelete;

  const _CommentWidget(
      {Key key, @required this.item, @required this.onTapDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = _buildImage(context, item.createBy?.user);
    return Flex(
      mainAxisSize: MainAxisSize.max,
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(child: image, flex: 1),
        Flexible(
            child: _CommentDescriptionWidget(
                item: item, onTapDelete: _onTapDelete),
            flex: 7),
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

  void _onTapDelete() {
    if (onTapDelete != null) onTapDelete();
  }
}
