part of petisland.pet_feed.widget.post;

class PostMoneyWidget extends StatelessWidget {
  final double money;
  final String typeMoney;
  final String title;

  const PostMoneyWidget({
    Key key,
    this.money,
    this.title = 'Free Now',
    this.typeMoney = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (money != null && money > 0) {
      FlutterMoneyFormatter formatter = FlutterMoneyFormatter(amount: money);
      return Text(
        '${formatter.output.withoutFractionDigits} $typeMoney',
        style: _buildTextStyle(theme),
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return Text(
        this.title, //free
        style: _buildTextStyle(theme),
        overflow: TextOverflow.ellipsis,
      );
    }
  }

  TextStyle _buildTextStyle(ThemeData theme) {
    return theme.textTheme.headline1.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: theme.primaryColor,
    );
  }
}
