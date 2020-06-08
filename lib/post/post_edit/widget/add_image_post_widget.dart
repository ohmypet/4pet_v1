part of petisland.post.post_edit.widget;

class AddImagePostWidget extends StatelessWidget {
  final void Function() onPress;

  const AddImagePostWidget({@required this.onPress, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPress,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: theme.primaryColor.withAlpha(50),
            alignment: Alignment.center,
            child: Icon(
              Icons.add,
              color: TColors.dark_sky_blue,
              size: 36,
            ),
          ),
        ),
      ),
    );
  }
}
