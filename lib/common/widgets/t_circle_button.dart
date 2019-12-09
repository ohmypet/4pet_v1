part of petisland.common.widgets;

class TCircleButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const TCircleButton({
    @required this.icon,
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: _onTap,
      child: Container(
        child: Theme(
          child: icon,
          data: theme.copyWith(
            iconTheme: IconThemeData(
              color: theme.primaryColor,
              size: 22,
            ),
          ),
        ),
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          boxShadow: TShadows.defaultShadow,
          shape: BoxShape.circle,
          color: TColors.white,
        ),
      ),
    );
  }

  void _onTap() {
    if (onTap != null) onTap();
  }
}
