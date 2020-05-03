part of petisland.pet_feed.widget.post;

class PostTitleWidget extends StatelessWidget {
  final String title;

  const PostTitleWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final String title = this.title ?? '';
    return Text(
      title,
      maxLines: 2,
      style: theme.textTheme.bodyText1.copyWith(
        color: theme.accentColor,
        fontSize: 18,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
        height: 1.4,
      ),
    );
  }
}
