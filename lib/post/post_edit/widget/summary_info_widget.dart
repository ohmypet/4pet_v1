part of petisland.post.post_edit.widget;

class SummaryInfoWidget extends TStatelessWidget {
  final List<String> petImage;
  final String title;
  final double price;

  SummaryInfoWidget(this.title, {this.petImage, this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TColors.white,
      margin: EdgeInsets.all(12),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildImageWidget(petImage),
          SizedBox(width: 12),
          _buildInfo(title, price),
        ],
      ),
    );
  }

  Widget _buildImageWidget(List<String> petImages) {
    String petImage;
    if (petImages != null && petImages.isNotEmpty) {
      petImage = petImages.first;
    }
    bool urlValid = petImage != null && petImage.isNotEmpty;
    Widget defaultImage = Container(
      color: TColors.duck_egg_blue,
    );
    return Flexible(
      flex: 1,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: urlValid ? Image.asset(petImage) : defaultImage,
      ),
    );
  }

  Widget _buildInfo(String title, double price) {
    return Flexible(
      flex: 2,
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: <Widget>[
          _buildTitleWidget(title),
          _buildPriceWidget(price),
        ],
      ),
    );
  }

  Widget _buildTitleWidget(String title) {
    title ??= "";
    return Text(
      title,
      style: TTextStyles.normal(fontSize: 20),
    );
  }

  Widget _buildPriceWidget(double money) {
    money ??= -1;
    FlutterMoneyFormatter formatter = FlutterMoneyFormatter(amount: money);
    return Text(
      money.isNegative
          ? "Miễn phí"
          : "${formatter.output.withoutFractionDigits} đ",
      style: TTextStyles.bold(fontSize: 22, color: TColors.red),
    );
  }
}
