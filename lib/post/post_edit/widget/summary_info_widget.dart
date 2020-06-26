part of petisland.post.post_edit.widget;

class SummaryInfoWidget extends TStatelessWidget {
  final List<String> petImage;
  final String title;
  final double money;
  final String location;
  final String customDefaultMoney;
  final String customDefaultTitle;
  final int maxHeros;
  final String typeMoney;

  SummaryInfoWidget(
    this.title, {
    this.petImage,
    this.money,
    this.location,
    this.customDefaultMoney = 'Free Now',
    this.maxHeros,
    this.typeMoney = '\$',
    this.customDefaultTitle = 'I want to sell ...'
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      color: TColors.white,
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildImageWidget(petImage),
          SizedBox(width: 12),
          _buildInfo(title, money, location),
        ],
      ),
    );
  }

  Widget _buildImageWidget(List<String> petImages) {
    String url;
    if (petImages != null && petImages.isNotEmpty) {
      url = petImages.first;
    }

    return PostImageWidget(imageUrl: url);
  }

  Widget _buildInfo(String title, double money, String location) {
    title = title.isEmpty ? customDefaultTitle : title;
    // location = location.isEmpty ? 'HCM' : location;
    return Flexible(
      flex: 2,
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: <Widget>[
          PostTitleWidget(title: title),
          PostMoneyWidget(money: money, title: customDefaultMoney, typeMoney: typeMoney),
          PostLocationWidget(location: location),
          maxHeros != null ? HeroTitleWidget(heroes: maxHeros) : const SizedBox(),
        ],
      ),
    );
  }

  bool isImageUrlFormat(String url) {
    return url.contains(RegExp('^https?://')) || url.contains(RegExp('^http?://'));
  }
}
