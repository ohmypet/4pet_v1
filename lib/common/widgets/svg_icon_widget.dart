part of petisland.common.widgets;

class SvgIconWidget extends StatelessWidget {
  final Widget icon;

  const SvgIconWidget({Key key, @required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      padding: const EdgeInsets.all(2),
      alignment: Alignment.center,
      child: icon,
    );
  }
}
