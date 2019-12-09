part of petisland.post.post_edit.widget;

class AddImagePostWidget extends StatelessWidget {
  final void Function() onPress;
  const AddImagePostWidget({@required this.onPress, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 100,
          width: 100,
          color: Colors.lightBlueAccent[100].withOpacity(0.5),
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.blueAccent[700],
              size: 36,
            ),
          ),
        ),
      ),
    );
  }
}
