part of petisland.login.widget;

class PetIslandButtonWidget extends TStatelessWidget {
  final String text;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const PetIslandButtonWidget({
    @required this.text,
    this.onTap,
    Key key,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
    this.margin = const EdgeInsets.symmetric(vertical: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: _onPressed,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: themeData.primaryColor,
        ),
        child: Center(
          child: Text(
            text,
            style: themeData.accentTextTheme.button.copyWith(fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    if (onTap != null) onTap();
  }
}
