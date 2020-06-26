part of petisland.profile.widget;

class CoinHistoryWidget extends StatelessWidget {
  final CoinHistory coinHistory;

  const CoinHistoryWidget({Key key, @required this.coinHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = coinHistory.change > 0 ? TColors.green : TColors.red;
    final coinAsText = coinHistory.change > 0
        ? '+${coinHistory.change} coins'
        : '${coinHistory.change} coins';
    return Container(
      height: 105,
      decoration: BoxDecoration(
        boxShadow: TShadows.innerShadow2,
        color: TColors.white,
        borderRadius: TConstants.border_all,
        border: Border.all(width: 0.8, color: primaryColor),
      ),
      padding: const EdgeInsets.all(10),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              coinHistory.title ?? '',
              style: TTextStyles.black(fontSize: 16, color: TColors.black.withAlpha(200)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              coinHistory.description ?? '',
              style: TTextStyles.light(fontSize: 13, color: TColors.brown_grey).copyWith(fontStyle: FontStyle.italic),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                coinAsText,
                style: TTextStyles.bold(fontSize: 14, color: primaryColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              TimeUtils.getTimeAgo(coinHistory.createAt),
              style: TTextStyles.light(fontSize: 13, color: TColors.brown_grey),
            ),
          )
        ],
      ),
    );
  }
}
