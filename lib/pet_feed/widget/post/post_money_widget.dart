part of petisland.pet_feed.widget.post;

class PostMoneyWidget extends StatelessWidget {
  final double price;

  const PostMoneyWidget({Key key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (price != null && price > 0) {
      FlutterMoneyFormatter formatter = FlutterMoneyFormatter(amount: price);
      return Text(
        '${formatter.output.withoutFractionDigits} \$',
        style: _buildTextStyle(theme),
      );
    } else {
      return Text(
        'Free Now', //free
        style: _buildTextStyle(theme),
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
