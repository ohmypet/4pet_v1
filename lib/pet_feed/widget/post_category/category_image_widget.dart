part of petisland.pet_feed.widget.post_category.dart;

class _CategoryImageWidget extends StatelessWidget {
  final PetCategory item;
  final BorderRadius borderRadius;

  const _CategoryImageWidget({Key key, @required this.item, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = _getImageUrl(item.image);
    return url != null ? TCacheImageWidget(url: url) : _buildImageDefaultWidget(item.name);
  }

  String _getImageUrl(PetImage image) {
    final url = image?.url?.trim();
    return url;
  }

  Widget _buildImageDefaultWidget(String type) {
    final BorderRadius borderRadius = this.borderRadius ?? BorderRadius.circular(4);
    final assetName = _getSvgPath(type);
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: TColors.black.withAlpha(15),
        borderRadius: borderRadius,
      ),
      child: SvgPicture.asset(assetName),
    );
  }

  String _getSvgPath(String type) {
    final petType = PetIslandConstants.getPetType(type);
    switch (petType) {
      case PetType.Cat:
        return TAssets.pet_type_cat;
      case PetType.Dog:
        return TAssets.pet_type_dog;
      case PetType.Bird:
        return TAssets.pet_type_bird;
      case PetType.Fish:
        return TAssets.pet_type_fish;
      default:
        return TAssets.pet_type_other;
    }
  }
}
