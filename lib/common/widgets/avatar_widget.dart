part of petisland.common.widgets;

class AvatarWidget extends StatelessWidget {
  final String url;
  final EdgeInsetsGeometry paddingDefaultImage;
  final bool fullScreenOnTap;
  AvatarWidget({
    Key key,
    this.url,
    this.paddingDefaultImage = const EdgeInsets.all(2.0),
    this.fullScreenOnTap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      if (fullScreenOnTap == true) {
        return PostImageWidget(
          isSquare: false,
          imageUrl: url,
          shape: BoxShape.circle,
          backGroundColor: TColors.white,
        );
      } else {
        ImageSources type = StringUtils.isImageUrlFormat(url) ? ImageSources.Server : ImageSources.Local;
        return _buildImage(type, url);
      }
    } else {
      return buildDefaultAvatar();
    }
  }

  Widget buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        color: TColors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: paddingDefaultImage,
        child: SvgPicture.asset(TAssets.user_avatar),
      ),
    );
  }

  Widget _buildImage(ImageSources type, String url) {
    if (type == ImageSources.Server) {
      return TCacheImageWidget(
        url: url,
        shape: BoxShape.circle,
      );
    } else {
      return Image.file(File(url));
    }
  }
}
