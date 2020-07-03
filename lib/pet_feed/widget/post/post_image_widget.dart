part of petisland.pet_feed.widget.post;

class PostImageWidget extends TStatelessWidget {
  final String imageUrl;
  static final Widget imageDefault = DefaultPetImage();
  final bool isSquare;
  final Object heroTag = ThinId.randomId();
  final BoxFit fit;
  final BoxShape shape;
  final Color backGroundColor;

  PostImageWidget(
      {Key key,
      this.imageUrl,
      this.isSquare = true,
      this.fit: BoxFit.cover,
      this.shape,
      this.backGroundColor = TColors.duck_egg_blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget image = imageUrl != null ? _buildImage(imageUrl, context) : imageDefault;
    return isSquare ? AspectRatio(child: image, aspectRatio: 1) : image;
  }

  Widget _buildImage(String imageUrl, BuildContext context) {
    final bool isFromServer = StringUtils.isImageUrlFormat(imageUrl);
    if (isFromServer) {
      return TCacheImageWidget(
        url: imageUrl,
        heroTag: heroTag,
        onTapImage: (_) => onTapImge(_, context),
        fit: fit,
        shape: shape,
        defaultBackgroundColor: backGroundColor,
      );
    } else {
      final imageProvider = FileImage(File(imageUrl));
      return GestureDetector(
        onTap: () => onTapImge(imageProvider, context),
        child: Hero(
          tag: heroTag,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: fit,
              ),
            ),
          ),
        ),
      );
    }
  }

  void onTapImge(ImageProvider provider, BuildContext context) {
    navigateToScreen(
      context: context,
      screen: PreviewImage(provider, heroTag, usePhotoView: true),
    );
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
