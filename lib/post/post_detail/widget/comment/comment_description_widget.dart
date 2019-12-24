part of petisland.post.screen.widget;

class _CommentDescriptionWidget extends StatelessWidget {
  final Comment item;

  const _CommentDescriptionWidget({Key key, this.item}) : super(key: key);

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
        Flexible(child: comment, flex: 3),
      ],
    );
  }

  Widget _buildName(BuildContext context, Account account) {
    final String name = account.user?.name ?? '@username';
    final isPermission = AccountUtils.grantEditAndDel(account);
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
