part of petisland.pet_feed.widget.post;

class _PostButtonBarWidget extends StatelessWidget {
  final List<Widget> children;

  const _PostButtonBarWidget({Key key, this.children = const <Widget>[]})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}
