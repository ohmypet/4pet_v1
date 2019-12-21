part of petisland.pet_feed.widget.post;

class PostImageWidget extends StatelessWidget {
  final Post item;
  final bool isSquare;
  final TapImage onTapImage;

  const PostImageWidget(
      {Key key, @required this.item, this.isSquare = true, this.onTapImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = getUrlImage(item.postImages);
    final onTap =
        onTapImage != null ? () => onTapImage(imageUrl, ImageType.Server) : null;
    final Widget image = imageUrl != null
        ? GestureDetector(
            child: TCacheImageWidget(url: imageUrl),
            onTap: onTap,
          )
        : buildDefaultPetImage();
    return isSquare ? AspectRatio(child: image, aspectRatio: 1) : image;
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
      TAssets.post_default_image_avatar,
    ),
  );
}
