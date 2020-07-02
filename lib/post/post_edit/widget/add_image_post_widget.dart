part of petisland.post.post_edit.widget;

class AddableWidget extends StatelessWidget {
  final void Function() onPress;

  const AddableWidget({this.onPress, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AspectRatio(
          aspectRatio: 1,
          child: DashedContainer(
            dashColor: TColors.water_melon,
            blankLength: 5,
            dashedLength: 5,
            strokeWidth: 3.5,
            child: Icon(
              Icons.add,
              color: TColors.water_melon,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
