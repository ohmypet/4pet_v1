part of petisland.post.screen.widget;

class CommentInputBarWidget extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final ValueChanged<String> onTapSend;

  CommentInputBarWidget({Key key, this.onTapSend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration:
          BoxDecoration(color: TColors.white, boxShadow: TShadows.innerShadow),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Flex(
        mainAxisSize: MainAxisSize.min,
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Opacity(
            opacity: 0.2,
            child: IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: _onTapIcon,
                color: theme.primaryColor),
          ),
          Flexible(child: CommentInputWidget(controller: controller)),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _onTapSend(context),
              color: theme.primaryColor),
        ],
      ),
    );
  }

  void _onTapIcon() {}

  void _onTapSend(BuildContext context) {
    final String text = controller.text?.trim() ?? '';
    controller.clear();
    _unFocusKeyBoard(context);
    if (onTapSend != null && text.isNotEmpty) onTapSend(text);
  }

  void _unFocusKeyBoard(BuildContext context) {
    try {
      if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
    } catch (ex) {
      //Ignore
    }
  }
}
