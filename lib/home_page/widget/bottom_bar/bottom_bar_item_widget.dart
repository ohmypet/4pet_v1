part of petisland.home_page.widget.bottom_bar;

class BottomBarItemWidget {
  final IconData icon;
  final double iconSize;

  BottomBarItemWidget(this.icon, {this.iconSize = 32});

  Widget buildSeletect(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Icon(
        icon,
        size: iconSize,
        color: theme.primaryColor,
      ),
    );
  }

  Widget buildUnSelect(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Icon(
        icon,
        size: iconSize,
        color: theme.accentColor,
      ),
    );
  }
}
