part of petisland.post.screen.widget;

class CommentWidget extends StatelessWidget {
  final Comment item;
  final VoidCallback onTapDelete;

  const CommentWidget({Key key, @required this.item, @required this.onTapDelete})
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
        const SizedBox(width: 5),
        Flexible(
          child: _CommentDescriptionWidget(
            item: item,
            onTapDelete: _onTapDelete,
          ),
          flex: 7,
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: CircleColorWidget(
          child: AvatarWidget(
            url: user?.avatar?.url,
          ),
        ),
      ),
    );
  }

  void _onTapDelete() {
    if (onTapDelete != null) onTapDelete();
  }
}
