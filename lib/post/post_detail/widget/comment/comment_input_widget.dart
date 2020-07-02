part of petisland.post.screen.widget;

class CommentInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const CommentInputWidget({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: TColors.duck_egg_blue.withAlpha(120),
      ),
      constraints: BoxConstraints(maxHeight: 150),
      padding: EdgeInsets.only(left: 10),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: controller,
              style: TTextStyles.light(fontSize: 16),
              textInputAction: TextInputAction.newline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          // TODO(tvc12): Support icon in the feature
          EnableWidget(
            enable: false,
            child: IconButton(
              icon: Icon(Icons.mood),
              onPressed: _onPressIcon,
              color: theme.primaryColor,
            ),
          )
        ],
      ),
    );
  }

  void _onPressIcon() {}
}
