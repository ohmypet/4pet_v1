part of petisland.post.screen.widget;

class PostDetailAppBar extends StatelessWidget {
  final VoidCallback onTapBack;
  final VoidCallback onTapSeeMore;

  const PostDetailAppBar({Key key, this.onTapBack, this.onTapSeeMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: _onTapBack,
            color: theme.accentColor,
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: _onTapQuestion,
            color: theme.primaryColor,
          ),
        ],
      ),
    );
  }

  void _onTapBack() {
    if (onTapBack != null) onTapBack();
  }

  void _onTapQuestion() {
    if (onTapSeeMore != null) onTapSeeMore();
  }
}
