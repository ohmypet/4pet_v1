part of petisland.post.post_edit.widget;

class SummaryInfoWidget extends TStatelessWidget {
  final List<String> petImage;
  final String title;
  final double price;
  final String location;
  final String customTitlePrice;
  final int maxHeros;
  static const Widget defaultImage = DefaultPetImage();

  SummaryInfoWidget(this.title,
      {this.petImage,
      this.price,
      this.location,
      this.customTitlePrice = 'Free Now',
      this.maxHeros});

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
          _buildInfo(title, price, location),
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
    Widget child;
    if (!urlValid) {
      child = defaultImage;
    } else {
      if (isImageUrlFormat(petImage)) {
        child = TCacheImageWidget(
          borderRadius: BorderRadius.circular(0),
          url: petImage,
        );
      } else {
        child = Image.file(
          File(petImage),
          fit: BoxFit.cover,
        );
      }
    }
    return Flexible(
      flex: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: child,
        ),
      ),
    );
  }

  Widget _buildInfo(String title, double price, String location) {
    title = title.isEmpty ? 'I want to ...' : title;
    // location = location.isEmpty ? 'HCM' : location;
    return Flexible(
      flex: 2,
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: <Widget>[
          PostTitleWidget(title: title),
          PostMoneyWidget(price: price, title: customTitlePrice),
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
