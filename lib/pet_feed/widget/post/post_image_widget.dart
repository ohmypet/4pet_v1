part of petisland.pet_feed.widget.post;

class PostImageWidget extends StatelessWidget {
  final String imageUrl;
  final bool isSquare;
  final TapImage onTapImage;
  final Widget imageDefault = DefaultPetImage();

  PostImageWidget(
      {Key key, this.imageUrl, this.isSquare = true, this.onTapImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onTap = onTapImage != null
        ? () => onTapImage(imageUrl, ImageSources.Server)
        : null;
    final Widget image = imageUrl != null
        ? GestureDetector(
            child: _buildImage(imageUrl),
            onTap: onTap,
          )
        : imageDefault;
    return isSquare ? AspectRatio(child: image, aspectRatio: 1) : image;
  }

  Widget _buildImage(String imageUrl) {
    final bool isFromServer = StringUtils.isImageUrlFormat(imageUrl);
    return isFromServer
        ? TCacheImageWidget(url: imageUrl)
        : Image.file(File(imageUrl));
  }
}

class DefaultPetImage extends StatelessWidget {
  const DefaultPetImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
