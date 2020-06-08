part of petisland.common.widgets;

TextStyle _getTitleTextStyle(BuildContext context) {
  final theme = Theme.of(context);
  return theme.textTheme.headline1.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: theme.accentColor.withAlpha(225),
  );
}

class TitleWidget extends StatelessWidget {
  final String title;
  final bool isRequired;
  final String subtitle;

  const TitleWidget({
    Key key,
    @required this.title,
    this.isRequired = false,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: _getTitleTextStyle(context),
          ),
          subtitle?.isNotEmpty == true
              ? TextSpan(
                  text: subtitle,
                  style: _getTitleTextStyle(context).copyWith(
                    color: TColors.red,
                    fontSize: 12
                  ),
                )
              : TextSpan(),
          isRequired
              ? TextSpan(
                  text: ' *',
                  style: _getTitleTextStyle(context).copyWith(color: TColors.red),
                )
              : TextSpan()
        ],
      ),
    );
  }
}
