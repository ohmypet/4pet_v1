part of petisland.post.screen.widget;

class PostDescriptionWidget extends StatelessWidget {
  final String description;

  const PostDescriptionWidget({Key key, this.description}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final description = this.description ?? '';
    final theme = Theme.of(context);
    return DefaultTextStyle(
      style: TTextStyles.semi(letterSpacing: 0.3, fontSize: 16, color: theme.accentColor),
      child: Text(description),
    );
  }
}
