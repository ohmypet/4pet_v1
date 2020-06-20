part of petisland.pet_feed.widget.post_panel;

class PanelDescriptionBar extends StatelessWidget {
  final String title;
  final String customSubTitle;
  final String customStringIcon;
  final VoidCallback onTapSubTitle;
  final bool enableSubtitle;
  final bool showSubtitle;

  const PanelDescriptionBar({
    Key key,
    @required this.title,
    this.onTapSubTitle,
    this.enableSubtitle = true,
    this.customSubTitle = 'See more',
    this.customStringIcon = ' >>',
    this.showSubtitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleWidget = _buildTitle(context, title);
    final seeMoreWidget =
        showSubtitle == true ? _buildSubTitle(context, _onTapSeeMore) : const SizedBox();
    return Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(child: titleWidget),
        EnableWidget(
          child: seeMoreWidget,
          enable: enableSubtitle,
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
