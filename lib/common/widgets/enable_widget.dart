part of petisland.common.widgets;

class EnableWidget extends StatelessWidget {
  final bool enable;
  final Widget child;

  const EnableWidget({Key key, this.enable, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (enable) {
      return child;
    } else {
      return IgnorePointer(
        ignoring: !enable,
        child: Opacity(
          child: child,
          opacity: 0.2,
        ),
      );
    }
  }
}
