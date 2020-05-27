part of petisland.post.screen.widget;

class _CommentDescriptionWidget extends StatelessWidget {
  final Comment item;
  final VoidCallback onTapDelete;

  const _CommentDescriptionWidget({Key key, this.item, @required this.onTapDelete})
      : super(key: key);

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
        Flexible(child: comment, flex: 5),
      ],
    );
  }

  Widget _buildName(BuildContext context, Account account) {
    final String name = account.getName();
    final isPermission = AccountUtils.grantEditAndDel(account);
    final text = DefaultTextStyle.merge(
      style: TTextStyles.semi(fontSize: 14, color: TColors.dark_sky_blue),
      child: Text(name),
    );
    final time = _buildTime(context, item.createAt);
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(child: text),
        Spacer(),
        time,
        isPermission
            ? GestureDetector(
                onTap: _onTapDelete,
                child: Icon(Icons.delete, size: 16, color: TColors.water_melon),
              )
            : SizedBox()
      ],
    );
  }

  Widget _buildComment(BuildContext context, String message) {
    final String comment = message ?? '';
    return DefaultTextStyle.merge(
      style: TTextStyles.medium(
        fontSize: 14,
        color: TColors.black.withAlpha(220),
      ),
      child: Text(comment),
    );
  }

  Widget _buildTime(BuildContext context, DateTime time) {
    final textTime = TimeUtils.toPm(time);
    return DefaultTextStyle.merge(
      style: TTextStyles.light(fontSize: 14, color: TColors.duck_egg_blue.withAlpha(220)),
      child: Text(textTime),
    );
  }

  void _onTapDelete() {
    if (onTapDelete != null) onTapDelete();
  }
}
