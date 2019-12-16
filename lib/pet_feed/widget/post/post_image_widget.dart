part of petisland.pet_feed.widget.post;

class _PostImageWidget extends StatelessWidget {
  final Post item;
  static final defaultImage = buildDefaultPetImage();

  const _PostImageWidget({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = getUrlImage(item.postImages);
    return AspectRatio(
      child: imageUrl != null ? TCacheImageWidget(url: imageUrl) : buildDefaultPetImage(),
      aspectRatio: 1,
      // child: ,
    );
  }

  String getUrlImage(List<PostImage> images) {
    final PostImage image =
        images.firstWhere((image) => image.image.url != null, orElse: () => null);
    return image?.image?.url;
  }
}

Widget buildDefaultPetImage() {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: TColors.black.withAlpha(15),
      borderRadius: BorderRadius.circular(4),
    ),
    child: SvgPicture.asset(
      TAssets.post_default_image_avatar_2,
    ),
  );
}
