part of petisland.common.widgets;

class CircleColorWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const CircleColorWidget({
    Key key,
    @required this.child,
    this.padding = const EdgeInsets.all(2.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: TGradients.avatarGradient2,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
