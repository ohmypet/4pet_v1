part of petisland.pet_feed.widget.post_panel;

class _TrendingDescriptionBar extends StatelessWidget {
  final Panel panel;
  final VoidCallback onTap;

  const _TrendingDescriptionBar({Key key, @required this.panel, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = PetIslandConstants.getCategoryStringFromType(panel.type);
    final Widget titleWidget = _buildTitle(context, title);
    final Widget seeMoreWidget = _buildSeeMore(context, _onTapSeeMore);
    return Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(child: titleWidget),
        seeMoreWidget,
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    final style = theme.textTheme.subtitle.copyWith(
      fontSize: 20,
      color: theme.accentColor.withAlpha(220),
      letterSpacing: 0.2,
    );
    return Text(title, style: style);
  }

  Widget _buildSeeMore(BuildContext context, VoidCallback onTap) {
    final theme = Theme.of(context);
    final style = theme.textTheme.subtitle.copyWith(
      fontSize: 14,
      color: theme.primaryColor,
      letterSpacing: 0.2,
    );
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Xem thêm',
              style: style.copyWith(decoration: TextDecoration.underline),
            ),
            TextSpan(text: ' >>', style: style.copyWith(fontSize: 12))
          ],
        ),
      ),
    );
  }

  void _onTapSeeMore() {
    if (onTap != null) onTap();
  }
}
