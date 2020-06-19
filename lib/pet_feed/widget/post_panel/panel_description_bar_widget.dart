part of petisland.pet_feed.widget.post_panel;

class PanelDescriptionBar extends StatelessWidget {
  final String title;
  final String customSubTitle;
  final String customStringIcon;
  final VoidCallback onTapSubTitle;
  final bool enableSeeMore;

  const PanelDescriptionBar({
    Key key,
    @required this.title,
    this.onTapSubTitle,
    this.enableSeeMore = true,
    this.customSubTitle = 'See more',
    this.customStringIcon = ' >>'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget titleWidget = _buildTitle(context, title);
    final Widget seeMoreWidget = _buildSubTitle(context, _onTapSeeMore);
    return Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(child: titleWidget),
        EnableWidget(
          child: seeMoreWidget,
          enable: enableSeeMore,
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    final style = theme.textTheme.subtitle2.copyWith(
      fontSize: 18,
      color: theme.accentColor.withAlpha(220),
      letterSpacing: 0.2,
      fontWeight: FontWeight.w700,
    );
    return Text(title, style: style);
  }

  Widget _buildSubTitle(BuildContext context, VoidCallback onTap) {
    final theme = Theme.of(context);
    final style = theme.textTheme.subtitle2.copyWith(
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
              text: this.customSubTitle,
              style: style.copyWith(decoration: TextDecoration.underline),
            ),
            TextSpan(text: this.customStringIcon, style: style.copyWith(fontSize: 12))
          ],
        ),
      ),
    );
  }

  void _onTapSeeMore() {
    if (onTapSubTitle != null) onTapSubTitle();
  }
}
