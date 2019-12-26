part of petisland.post.post_edit.widget;

class SummaryInfoWidget extends TStatelessWidget {
  final List<String> petImage;
  final String title;
  final double price;
  final String location;

  SummaryInfoWidget(this.title, {this.petImage, this.price, this.location});

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
    Widget defaultImage = buildDefaultPetImage();
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
    title = title.isEmpty ? 'Thú cứng của bạn' : title;
    // location = location.isEmpty ? 'HCM' : location;
    return Flexible(
      flex: 2,
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: <Widget>[
          PostTitleWidget(title: title),
          PostMoneyWidget(price: price),
          PostLocationWidget(location: location),
          PostTimeWidget(time: DateTime.now())
        ],
      ),
    );
  }

  bool isImageUrlFormat(String url) {
    return url.contains(RegExp('^https?://')) || url.contains(RegExp('^http?://'));
  }
}
